-- Migración: Arreglo del registro de trabajadores desde la plataforma web
-- Habilita pgcrypto para hashear contraseñas con bcrypt (crypt/gen_salt)
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Función para registrar atómicamente usuario + perfil de trabajador
-- SECURITY DEFINER: se ejecuta como dueño de la función y omite RLS para los INSERT.
CREATE OR REPLACE FUNCTION register_worker_profile(
    p_tenant_id uuid,
    p_email text,
    p_password text,
    p_role text,
    p_rut text,
    p_first_name text,
    p_last_name text,
    p_phone text,
    p_license_class text
) RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
    v_normalized_email text := lower(btrim(p_email));
    v_role text := upper(btrim(p_role));
    v_user_id uuid;
    v_worker_id uuid;
    v_password_hash text;
BEGIN
    -- Normalizar y validar rol admitido por el CHECK (role IN ADMIN, SUPERVISOR, WORKER)
    IF v_role NOT IN ('ADMIN', 'SUPERVISOR', 'WORKER') THEN
        RAISE EXCEPTION 'Rol inválido: %', v_role;
    END IF;

    -- Evitar duplicados de correo (users.email es UNIQUE)
    IF EXISTS (SELECT 1 FROM users WHERE email = v_normalized_email) THEN
        RAISE EXCEPTION 'Ya existe un usuario con el correo %.', v_normalized_email;
    END IF;

    -- Hashear contraseña con bcrypt compatible con el backend NestJS (bcrypt.compare)
    v_password_hash := crypt(p_password, gen_salt('bf', 10));

    -- Insertar usuario
    INSERT INTO users (tenant_id, email, password_hash, role, is_active)
    VALUES (p_tenant_id, v_normalized_email, v_password_hash, v_role, TRUE)
    RETURNING id INTO v_user_id;

    -- Insertar perfil de trabajador
    INSERT INTO workers_profile (
        tenant_id, user_id, rut, first_name, last_name, phone, license_class
    )
    VALUES (
        p_tenant_id, v_user_id, btrim(p_rut), btrim(p_first_name), btrim(p_last_name),
        NULLIF(btrim(p_phone), ''), NULLIF(btrim(p_license_class), '')
    )
    RETURNING id INTO v_worker_id;

    RETURN jsonb_build_object('user_id', v_user_id, 'worker_id', v_worker_id);
END;
$$;

-- Permitir ejecución a los roles usados por el cliente web (anon key) y usuarios autenticados
REVOKE ALL ON FUNCTION register_worker_profile(uuid, text, text, text, text, text, text, text, text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION register_worker_profile(uuid, text, text, text, text, text, text, text, text) TO anon, authenticated;

-- RLS: permitir lectura a la consola web para el listado de trabajadores.
-- Los INSERT siguen protegidos: solo la función SECURITY DEFINER los ejecuta.
CREATE POLICY allow_web_read_users ON users
    FOR SELECT TO anon, authenticated USING (true);

CREATE POLICY allow_web_read_workers_profile ON workers_profile
    FOR SELECT TO anon, authenticated USING (true);