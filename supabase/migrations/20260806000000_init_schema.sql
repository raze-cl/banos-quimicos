-- Migración SQL Inicial: Plataforma de Gestión Operacional para Faenas Mineras
-- Habilita la extensión UUID si no existe
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Crear esquema y funciones 'auth' de compatibilidad para PostgreSQL local vanilla
CREATE SCHEMA IF NOT EXISTS auth;
CREATE OR REPLACE FUNCTION auth.jwt() RETURNS jsonb AS $$
BEGIN
    RETURN '{}'::jsonb;
END;
$$ LANGUAGE plpgsql STABLE;


-- 1. TABLA: tenants (Inquilinos)
CREATE TABLE tenants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    rut VARCHAR(50) UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. TABLA: users (Usuarios de la plataforma, mapea con auth.users de Supabase)
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL CHECK (role IN ('ADMIN', 'SUPERVISOR', 'WORKER')),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. TABLA: workers_profile (Perfiles de los operarios)
CREATE TABLE workers_profile (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    user_id UUID UNIQUE NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    rut VARCHAR(50) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(50),
    license_number VARCHAR(100),
    license_class VARCHAR(50),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. TABLA: worker_documents (Documentación del trabajador)
CREATE TABLE worker_documents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    worker_id UUID NOT NULL REFERENCES workers_profile(id) ON DELETE CASCADE,
    document_type VARCHAR(100) NOT NULL CHECK (document_type IN ('IDENTITY_CARD', 'DRIVERS_LICENSE', 'MEDICAL_EXAM', 'FAENA_PASS')),
    emission_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    file_url VARCHAR(512),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. TABLA: vehicles (Flota de camiones y vehículos)
CREATE TABLE vehicles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    plate_number VARCHAR(50) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    last_odometer INT DEFAULT 0,
    qr_code_token VARCHAR(255) UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_plate_per_tenant UNIQUE (tenant_id, plate_number)
);

-- 6. TABLA: vehicle_documents (Documentación del vehículo)
CREATE TABLE vehicle_documents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    vehicle_id UUID NOT NULL REFERENCES vehicles(id) ON DELETE CASCADE,
    document_type VARCHAR(100) NOT NULL CHECK (document_type IN ('PERMIT', 'SOAP', 'TECH_REVIEW', 'GAS_CERT')),
    emission_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    file_url VARCHAR(512),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 7. TABLA: checklists (Formularios parametrizables)
CREATE TABLE checklists (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    version INT DEFAULT 1,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 8. TABLA: checklist_questions (Preguntas asociadas a checklists)
CREATE TABLE checklist_questions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    checklist_id UUID NOT NULL REFERENCES checklists(id) ON DELETE CASCADE,
    question_text TEXT NOT NULL,
    question_type VARCHAR(50) NOT NULL CHECK (question_type IN ('YES_NO', 'MULTIPLE_CHOICE', 'TEXT', 'NUMBER', 'PHOTO', 'SIGNATURE')),
    is_required BOOLEAN DEFAULT TRUE,
    is_critical BOOLEAN DEFAULT FALSE,
    sort_order INT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 9. TABLA: checklist_question_options (Opciones para preguntas de selección múltiple)
CREATE TABLE checklist_question_options (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    question_id UUID NOT NULL REFERENCES checklist_questions(id) ON DELETE CASCADE,
    option_text VARCHAR(255) NOT NULL,
    is_critical_trigger BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 10. TABLA: routes (Rutas operacionales programadas)
CREATE TABLE routes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    assigned_worker_id UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    name VARCHAR(255) NOT NULL,
    client_name VARCHAR(255) NOT NULL,
    faena_name VARCHAR(255) NOT NULL,
    status VARCHAR(50) DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'IN_PROGRESS', 'COMPLETED')),
    scheduled_date DATE NOT NULL,
    started_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 11. TABLA: route_points (Puntos de control asignados a rutas)
CREATE TABLE route_points (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    route_id UUID NOT NULL REFERENCES routes(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    qr_code_token VARCHAR(255) NOT NULL,
    sequence_order INT NOT NULL,
    status VARCHAR(50) DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'COMPLETED', 'OMITTED')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 12. TABLA: route_point_visits (Atención operacional offline a los puntos)
CREATE TABLE route_point_visits (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    point_id UUID NOT NULL REFERENCES route_points(id) ON DELETE CASCADE,
    visited_at TIMESTAMP WITH TIME ZONE NOT NULL,
    gps_lat DOUBLE PRECISION NOT NULL,
    gps_lon DOUBLE PRECISION NOT NULL,
    gps_accuracy DOUBLE PRECISION NOT NULL,
    photos_before TEXT[] DEFAULT '{}',
    photos_after TEXT[] DEFAULT '{}',
    form_data JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 13. TABLA: checklists_submissions (Checklists de fatiga, pre-uso, etc. ejecutados)
CREATE TABLE checklists_submissions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    vehicle_id UUID REFERENCES vehicles(id) ON DELETE SET NULL,
    route_id UUID REFERENCES routes(id) ON DELETE SET NULL,
    checklist_id UUID NOT NULL REFERENCES checklists(id) ON DELETE RESTRICT,
    submitted_at TIMESTAMP WITH TIME ZONE NOT NULL,
    gps_lat DOUBLE PRECISION NOT NULL,
    gps_lon DOUBLE PRECISION NOT NULL,
    gps_accuracy DOUBLE PRECISION NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 14. TABLA: checklist_answers (Respuestas detalladas de los checklists)
CREATE TABLE checklist_answers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    submission_id UUID NOT NULL REFERENCES checklists_submissions(id) ON DELETE CASCADE,
    question_id UUID NOT NULL REFERENCES checklist_questions(id) ON DELETE RESTRICT,
    answer_value TEXT NOT NULL,
    photo_url VARCHAR(512),
    signature_url VARCHAR(512),
    is_failed_critical BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 15. TABLA: audit_logs (Bitácora inmutable de auditoría)
CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    action VARCHAR(255) NOT NULL,
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    device_info VARCHAR(255),
    gps_lat DOUBLE PRECISION,
    gps_lon DOUBLE PRECISION,
    payload JSONB DEFAULT '{}'::jsonb
);

-- -------------------------------------------------------------
-- CONFIGURACIÓN DE SEGURIDAD: ROW LEVEL SECURITY (RLS)
-- -------------------------------------------------------------

-- Habilitar RLS en cada tabla del sistema (excepto tenants, que se maneja de forma especial)
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE workers_profile ENABLE ROW LEVEL SECURITY;
ALTER TABLE worker_documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE vehicles ENABLE ROW LEVEL SECURITY;
ALTER TABLE vehicle_documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE checklists ENABLE ROW LEVEL SECURITY;
ALTER TABLE checklist_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE checklist_question_options ENABLE ROW LEVEL SECURITY;
ALTER TABLE routes ENABLE ROW LEVEL SECURITY;
ALTER TABLE route_points ENABLE ROW LEVEL SECURITY;
ALTER TABLE route_point_visits ENABLE ROW LEVEL SECURITY;
ALTER TABLE checklists_submissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE checklist_answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_logs ENABLE ROW LEVEL SECURITY;

-- Crear políticas basadas en el tenant_id (acepta variable de sesión app.current_tenant_id de NestJS o JWT de Supabase)
-- Nota: La política filtra los datos comparando el tenant_id de la fila con la variable de sesión o el JWT.

CREATE POLICY tenant_isolation_users ON users 
    FOR ALL USING (tenant_id = coalesce(nullif(current_setting('app.current_tenant_id', true), ''), auth.jwt() ->> 'tenant_id')::uuid);

CREATE POLICY tenant_isolation_workers_profile ON workers_profile 
    FOR ALL USING (tenant_id = coalesce(nullif(current_setting('app.current_tenant_id', true), ''), auth.jwt() ->> 'tenant_id')::uuid);

CREATE POLICY tenant_isolation_worker_documents ON worker_documents 
    FOR ALL USING (tenant_id = coalesce(nullif(current_setting('app.current_tenant_id', true), ''), auth.jwt() ->> 'tenant_id')::uuid);

CREATE POLICY tenant_isolation_vehicles ON vehicles 
    FOR ALL USING (tenant_id = coalesce(nullif(current_setting('app.current_tenant_id', true), ''), auth.jwt() ->> 'tenant_id')::uuid);

CREATE POLICY tenant_isolation_vehicle_documents ON vehicle_documents 
    FOR ALL USING (tenant_id = coalesce(nullif(current_setting('app.current_tenant_id', true), ''), auth.jwt() ->> 'tenant_id')::uuid);

CREATE POLICY tenant_isolation_checklists ON checklists 
    FOR ALL USING (tenant_id = coalesce(nullif(current_setting('app.current_tenant_id', true), ''), auth.jwt() ->> 'tenant_id')::uuid);

CREATE POLICY tenant_isolation_checklist_questions ON checklist_questions 
    FOR ALL USING (tenant_id = coalesce(nullif(current_setting('app.current_tenant_id', true), ''), auth.jwt() ->> 'tenant_id')::uuid);

CREATE POLICY tenant_isolation_checklist_question_options ON checklist_question_options 
    FOR ALL USING (tenant_id = coalesce(nullif(current_setting('app.current_tenant_id', true), ''), auth.jwt() ->> 'tenant_id')::uuid);

CREATE POLICY tenant_isolation_routes ON routes 
    FOR ALL USING (tenant_id = coalesce(nullif(current_setting('app.current_tenant_id', true), ''), auth.jwt() ->> 'tenant_id')::uuid);

CREATE POLICY tenant_isolation_route_points ON route_points 
    FOR ALL USING (tenant_id = coalesce(nullif(current_setting('app.current_tenant_id', true), ''), auth.jwt() ->> 'tenant_id')::uuid);

CREATE POLICY tenant_isolation_route_point_visits ON route_point_visits 
    FOR ALL USING (tenant_id = coalesce(nullif(current_setting('app.current_tenant_id', true), ''), auth.jwt() ->> 'tenant_id')::uuid);

CREATE POLICY tenant_isolation_checklists_submissions ON checklists_submissions 
    FOR ALL USING (tenant_id = coalesce(nullif(current_setting('app.current_tenant_id', true), ''), auth.jwt() ->> 'tenant_id')::uuid);

CREATE POLICY tenant_isolation_checklist_answers ON checklist_answers 
    FOR ALL USING (tenant_id = coalesce(nullif(current_setting('app.current_tenant_id', true), ''), auth.jwt() ->> 'tenant_id')::uuid);

CREATE POLICY tenant_isolation_audit_logs ON audit_logs 
    FOR ALL USING (tenant_id = coalesce(nullif(current_setting('app.current_tenant_id', true), ''), auth.jwt() ->> 'tenant_id')::uuid);

-- -------------------------------------------------------------
-- TRIGGERS PARA ACTUALIZACIÓN AUTOMÁTICA DE UPDATED_AT
-- -------------------------------------------------------------

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_tenants_updated_at BEFORE UPDATE ON tenants FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_workers_profile_updated_at BEFORE UPDATE ON workers_profile FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_worker_documents_updated_at BEFORE UPDATE ON worker_documents FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_vehicles_updated_at BEFORE UPDATE ON vehicles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_vehicle_documents_updated_at BEFORE UPDATE ON vehicle_documents FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_checklists_updated_at BEFORE UPDATE ON checklists FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_checklist_questions_updated_at BEFORE UPDATE ON checklist_questions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_routes_updated_at BEFORE UPDATE ON routes FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_route_points_updated_at BEFORE UPDATE ON route_points FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
