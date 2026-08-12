import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || 'https://wqrybklmfjbgxmsnpyqn.supabase.co';
const supabaseAnonKey =
  import.meta.env.VITE_SUPABASE_ANON_KEY ||
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indxcnlia2xtZmpiZ3htc25weXFuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODY0OTI2MDAsImV4cCI6MjEwMjA2ODYwMH0.hYSDoO-FWVOAwvzWtYsDdYPnA42C1ZjV_wGlpRt5oKs';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export const DEFAULT_TENANT_ID = '00000000-0000-0000-0000-000000000001';
