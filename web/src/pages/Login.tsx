import React, { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext';
import { useNavigate } from 'react-router-dom';
import api from '../core/api';
import {
  Container,
  Box,
  Typography,
  TextField,
  Button,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Card,
  CardContent,
  Alert,
  CircularProgress,
  Avatar,
} from '@mui/material';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';

interface Tenant {
  id: string;
  name: string;
}

export const Login: React.FC = () => {
  const { login, isAuthenticated } = useAuth();
  const navigate = useNavigate();

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [tenantId, setTenantId] = useState('');
  const [tenants, setTenants] = useState<Tenant[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [loadingTenants, setLoadingTenants] = useState(true);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (isAuthenticated) {
      navigate('/dashboard');
    }
  }, [isAuthenticated, navigate]);

  useEffect(() => {
    const fetchTenants = async () => {
      try {
        const response = await api.get('/api/v1/tenants');
        setTenants(response.data);
      } catch (err) {
        setError('No se pudo cargar la lista de Inquilinos/Empresas.');
      } finally {
        setLoadingTenants(false);
      }
    };
    fetchTenants();
  }, []);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!tenantId) {
      setError('Por favor, selecciona una Empresa/Inquilino.');
      return;
    }
    setError(null);
    setSubmitting(true);
    try {
      await login(email, password, tenantId);
      navigate('/dashboard');
    } catch (err: any) {
      setError(
        err.response?.data?.message || 'Error de credenciales o de red. Reintente.'
      );
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <Box
      sx={{
        minHeight: '100vh',
        display: 'flex',
        alignItems: 'center',
        background: 'radial-gradient(circle, #1e293b 0%, #0f172a 100%)',
      }}
    >
      <Container maxWidth="sm">
        <Card sx={{ border: '1px solid rgba(148, 163, 184, 0.12)' }}>
          <CardContent sx={{ p: 4 }}>
            <Box sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center', mb: 4 }}>
              <Avatar
                sx={{
                  bgcolor: 'primary.dark',
                  color: 'primary.light',
                  width: 56,
                  height: 56,
                  mb: 2,
                }}
              >
                <LockOutlinedIcon fontSize="large" />
              </Avatar>
              <Typography variant="h4" sx={{ fontWeight: 900, textAlign: 'center' }} gutterBottom>
                PLATAFORMA OPERACIONAL
              </Typography>
              <Typography variant="body2" sx={{ color: 'text.secondary', textAlign: 'center' }}>
                Consola Administrativa de Control Minero y RLS
              </Typography>
            </Box>

            {error && (
              <Alert severity="error" sx={{ mb: 3 }}>
                {error}
              </Alert>
            )}

            <form onSubmit={handleSubmit}>
              <Box sx={{ display: 'flex', flexDirection: 'column', gap: 3 }}>
                <FormControl fullWidth disabled={loadingTenants}>
                  <InputLabel id="tenant-select-label">Empresa / Inquilino</InputLabel>
                  <Select
                    labelId="tenant-select-label"
                    value={tenantId}
                    label="Empresa / Inquilino"
                    onChange={(e) => setTenantId(e.target.value)}
                  >
                    {loadingTenants ? (
                      <MenuItem value="" disabled>
                        Cargando empresas...
                      </MenuItem>
                    ) : (
                      tenants.map((t) => (
                        <MenuItem key={t.id} value={t.id}>
                          {t.name}
                        </MenuItem>
                      ))
                    )}
                  </Select>
                </FormControl>

                <TextField
                  label="Correo Electrónico"
                  type="email"
                  fullWidth
                  required
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                />

                <TextField
                  label="Contraseña"
                  type="password"
                  fullWidth
                  required
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                />

                <Button
                  type="submit"
                  variant="contained"
                  color="primary"
                  size="large"
                  disabled={submitting}
                  sx={{ mt: 2 }}
                >
                  {submitting ? <CircularProgress size={24} color="inherit" /> : 'INICIAR SESIÓN'}
                </Button>
              </Box>
            </form>
          </CardContent>
        </Card>
      </Container>
    </Box>
  );
};
export default Login;
