# Integración de Supabase - Plataforma Baños Químicos / Faenas Mineras

Este directorio contiene las migraciones y esquemas SQL para desplegar la base de datos PostgreSQL en **Supabase**.

## 1. Archivo de Migración
- `migrations/20260806000000_init_schema.sql`: Contiene el esquema relacional completo:
  - `tenants` (Multi-arrendatario / Empresas)
  - `users` (Usuarios y roles)
  - `workers_profile` & `worker_documents` (Perfiles y semáforo de documentos)
  - `vehicles` & `vehicle_documents` (Flotas y semáforo vehicular)
  - `checklists`, `checklist_questions`, `checklists_submissions`, `checklist_answers` (Formularios parametrizables y respuestas)
  - `routes`, `route_points`, `route_point_visits` (Rutas y geolocalización)

## 2. Instrucciones de Despliegue en Supabase

### Opción A: Desde el Dashboard de Supabase (SQL Editor)
1. Ingresa a tu proyecto en [Supabase Dashboard](https://supabase.com/dashboard).
2. Ve a la sección **SQL Editor**.
3. Copia y pega el contenido completo de `supabase/migrations/20260806000000_init_schema.sql`.
4. Haz clic en **Run** para ejecutar la migración.

### Opción B: Mediante Supabase CLI
```bash
# Vincular con tu proyecto de Supabase
npx supabase link --project-ref TU_PROJECT_REF

# Aplicar las migraciones
npx supabase db push
```

## 3. Variables de Entorno Recomendadas (.env)
```env
SUPABASE_URL=https://tu-proyecto.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOi...
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOi...
```
