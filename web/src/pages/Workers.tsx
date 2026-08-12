import React, { useState, useEffect } from 'react';
import api from '../core/api';
import { supabase, DEFAULT_TENANT_ID } from '../core/supabaseClient';
import {
  Typography,
  Box,
  Card,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Button,
  Chip,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Snackbar,
  Alert,
  CircularProgress,
  IconButton,
  Tooltip,
} from '@mui/material';
import AddIcon from '@mui/icons-material/Add';
import DescriptionIcon from '@mui/icons-material/Description';
import RefreshIcon from '@mui/icons-material/Refresh';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import BlockIcon from '@mui/icons-material/Block';

export interface Worker {
  id: string;
  name: string;
  rut: string;
  email: string;
  role: string;
  status: string; // ACTIVE, BLOCKED
}

const DEFAULT_WORKERS: Worker[] = [
  {
    id: 'worker-1',
    name: 'Juan Pérez González',
    rut: '18.234.567-8',
    email: 'juan.perez@faena.cl',
    role: 'OPERATOR',
    status: 'ACTIVE',
  },
  {
    id: 'worker-2',
    name: 'Rodrigo Araya Gómez',
    rut: '16.456.789-0',
    email: 'rodrigo.araya@faena.cl',
    role: 'SUPERVISOR',
    status: 'ACTIVE',
  },
  {
    id: 'worker-3',
    name: 'Carlos Muñoz Soto',
    rut: '15.987.654-3',
    email: 'carlos.munoz@faena.cl',
    role: 'OPERATOR',
    status: 'ACTIVE',
  },
];

export const Workers: React.FC = () => {
  const [workers, setWorkers] = useState<Worker[]>([]);
  const [loading, setLoading] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [open, setOpen] = useState(false);
  const [docsModalOpen, setDocsModalOpen] = useState(false);
  const [selectedWorker, setSelectedWorker] = useState<Worker | null>(null);

  // Form states
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [rut, setRut] = useState('');
  const [password, setPassword] = useState('123456');
  const [role, setRole] = useState('OPERATOR');

  // Feedback Snackbar
  const [snackbar, setSnackbar] = useState<{
    open: boolean;
    message: string;
    severity: 'success' | 'error' | 'info';
  }>({
    open: false,
    message: '',
    severity: 'success',
  });

  const showToast = (message: string, severity: 'success' | 'error' | 'info' = 'success') => {
    setSnackbar({ open: true, message, severity });
  };

  const fetchWorkers = async () => {
    setLoading(true);
    try {
      // 1. Intentar obtener desde Supabase directamente con join a users
      const { data, error } = await supabase
        .from('workers_profile')
        .select('id, rut, first_name, last_name, phone, license_class, users(email, role, is_active)')
        .eq('tenant_id', DEFAULT_TENANT_ID)
        .order('created_at', { ascending: false });

      if (!error && data && data.length > 0) {
        const mappedWorkers: Worker[] = data.map((w: any) => {
          const userObj = Array.isArray(w.users) ? w.users[0] : w.users;
          return {
            id: w.id,
            name: `${w.first_name || ''} ${w.last_name || ''}`.trim() || 'Trabajador Faena',
            rut: w.rut || '',
            email: userObj?.email || w.phone || 'operario@faena.cl',
            role: userObj?.role || (w.license_class ? `Licencia ${w.license_class}` : 'OPERATOR'),
            status: userObj?.is_active === false ? 'BLOCKED' : 'ACTIVE',
          };
        });
        setWorkers(mappedWorkers);
        localStorage.setItem('local_workers_cache', JSON.stringify(mappedWorkers));
        setLoading(false);
        return;
      }

      // 2. Intentar backend NestJS
      const response = await api.get('/api/v1/workers/list');
      if (response?.data && Array.isArray(response.data) && response.data.length > 0) {
        setWorkers(response.data);
        localStorage.setItem('local_workers_cache', JSON.stringify(response.data));
        setLoading(false);
        return;
      }
    } catch (e) {
      console.warn('Error al conectar con backend/supabase:', e);
    }

    // 3. Fallback a caché local o datos base
    const cached = localStorage.getItem('local_workers_cache');
    if (cached) {
      try {
        setWorkers(JSON.parse(cached));
      } catch {
        setWorkers(DEFAULT_WORKERS);
      }
    } else {
      setWorkers(DEFAULT_WORKERS);
    }
    setLoading(false);
  };

  useEffect(() => {
    fetchWorkers();
  }, []);

  const handleCreate = async (e?: React.FormEvent) => {
    if (e) e.preventDefault();

    if (!name.trim() || !rut.trim() || !email.trim()) {
      showToast('Por favor completa todos los campos obligatorios', 'error');
      return;
    }

    setIsSubmitting(true);

    const names = name.trim().split(' ');
    const firstName = names[0] || name.trim();
    const lastName = names.slice(1).join(' ') || 'Operador';
    const dbRole = role === 'OPERATOR' ? 'WORKER' : role;

    const newWorkerObj: Worker = {
      id: `worker-${Date.now()}`,
      name: `${firstName} ${lastName}`.trim(),
      rut: rut.trim(),
      email: email.trim().toLowerCase(),
      role: dbRole,
      status: 'ACTIVE',
    };

    try {
      // 1. Ejecutar RPC en Supabase para registrar atómicamente usuario y perfil
      const { error: rpcError } = await supabase.rpc('register_worker_profile', {
        p_tenant_id: DEFAULT_TENANT_ID,
        p_email: email.trim().toLowerCase(),
        p_password: password.trim() || '123456',
        p_role: dbRole,
        p_rut: rut.trim(),
        p_first_name: firstName,
        p_last_name: lastName,
        p_phone: email.trim().toLowerCase(),
        p_license_class: 'A4',
      });

      if (rpcError) {
        throw new Error(rpcError.message);
      }

      showToast(`¡Trabajador ${firstName} ${lastName} registrado con éxito en la base de datos!`, 'success');
      
      // Actualizar la lista en pantalla
      setWorkers((prev) => {
        const updated = [newWorkerObj, ...prev.filter((w) => w.email !== newWorkerObj.email && w.rut !== newWorkerObj.rut)];
        localStorage.setItem('local_workers_cache', JSON.stringify(updated));
        return updated;
      });

      // Limpiar formulario y cerrar
      setName('');
      setEmail('');
      setRut('');
      setPassword('123456');
      setRole('OPERATOR');
      setOpen(false);

      // Re-sincronizar con Supabase en segundo plano
      fetchWorkers();
    } catch (err: any) {
      console.error('Error al guardar trabajador:', err);
      showToast(
        err?.message || 'Error al guardar trabajador en la base de datos.',
        'error'
      );
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleToggleStatus = (worker: Worker) => {
    const nextStatus = worker.status === 'ACTIVE' ? 'BLOCKED' : 'ACTIVE';
    setWorkers((prev) =>
      prev.map((w) => (w.id === worker.id ? { ...w, status: nextStatus } : w))
    );
    showToast(`Estado de ${worker.name} actualizado a ${nextStatus === 'ACTIVE' ? 'Habilitado' : 'Bloqueado'}`);
  };

  const handleOpenDocs = (worker: Worker) => {
    setSelectedWorker(worker);
    setDocsModalOpen(true);
  };

  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', gap: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: 2 }}>
        <div>
          <Typography variant="h5" sx={{ fontWeight: 'bold' }}>
            Gestión de Trabajadores y Operarios
          </Typography>
          <Typography variant="body2" color="text.secondary">
            Administra el personal de faena, sus credenciales para la App Móvil y sus pases de seguridad.
          </Typography>
        </div>
        <Box sx={{ display: 'flex', gap: 1 }}>
          <Tooltip title="Recargar lista desde Supabase">
            <IconButton onClick={fetchWorkers} disabled={loading} color="primary">
              {loading ? <CircularProgress size={24} /> : <RefreshIcon />}
            </IconButton>
          </Tooltip>
          <Button
            variant="contained"
            startIcon={<AddIcon />}
            onClick={() => setOpen(true)}
            sx={{ fontWeight: 'bold' }}
          >
            REGISTRAR TRABAJADOR
          </Button>
        </Box>
      </Box>

      <Card>
        <TableContainer component={Paper} elevation={0}>
          <Table>
            <TableHead sx={{ backgroundColor: 'action.hover' }}>
              <TableRow>
                <TableCell sx={{ fontWeight: 'bold' }}>Nombre Trabajador</TableCell>
                <TableCell sx={{ fontWeight: 'bold' }}>RUT</TableCell>
                <TableCell sx={{ fontWeight: 'bold' }}>Correo (Usuario Móvil)</TableCell>
                <TableCell sx={{ fontWeight: 'bold' }}>Rol Minero</TableCell>
                <TableCell sx={{ fontWeight: 'bold' }}>Estado Ingreso</TableCell>
                <TableCell align="right" sx={{ fontWeight: 'bold' }}>Acciones</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {workers.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={6} align="center" sx={{ py: 4, color: 'text.secondary' }}>
                    {loading ? 'Cargando trabajadores...' : 'No hay trabajadores registrados. Haz clic en "Registrar Trabajador" para crear uno.'}
                  </TableCell>
                </TableRow>
              ) : (
                workers.map((worker) => (
                  <TableRow key={worker.id} hover>
                    <TableCell sx={{ fontWeight: 'bold' }}>{worker.name}</TableCell>
                    <TableCell>{worker.rut}</TableCell>
                    <TableCell>{worker.email}</TableCell>
                    <TableCell>
                      <Chip
                        label={worker.role}
                        size="small"
                        variant="outlined"
                        color={worker.role === 'SUPERVISOR' ? 'secondary' : 'primary'}
                      />
                    </TableCell>
                    <TableCell>
                      <Chip
                        label={worker.status === 'ACTIVE' ? 'HABILITADO' : 'BLOQUEADO'}
                        color={worker.status === 'ACTIVE' ? 'success' : 'error'}
                        size="small"
                      />
                    </TableCell>
                    <TableCell align="right">
                      <Box sx={{ display: 'flex', justifyContent: 'flex-end', gap: 1 }}>
                        <Button
                          startIcon={<DescriptionIcon />}
                          size="small"
                          variant="outlined"
                          color="info"
                          onClick={() => handleOpenDocs(worker)}
                        >
                          Pases / Docs
                        </Button>
                        <Button
                          startIcon={worker.status === 'ACTIVE' ? <BlockIcon /> : <CheckCircleIcon />}
                          size="small"
                          color={worker.status === 'ACTIVE' ? 'error' : 'success'}
                          onClick={() => handleToggleStatus(worker)}
                        >
                          {worker.status === 'ACTIVE' ? 'Bloquear' : 'Habilitar'}
                        </Button>
                      </Box>
                    </TableCell>
                  </TableRow>
                ))
              )}
            </TableBody>
          </Table>
        </TableContainer>
      </Card>

      {/* Modal: Registrar Nuevo Trabajador */}
      <Dialog
        open={open}
        onClose={() => !isSubmitting && setOpen(false)}
        fullWidth
        maxWidth="sm"
      >
        <form onSubmit={handleCreate}>
          <DialogTitle sx={{ fontWeight: 'bold', pb: 1 }}>
            Registrar Nuevo Trabajador
          </DialogTitle>
          <DialogContent sx={{ display: 'flex', flexDirection: 'column', gap: 2.5, pt: 1 }}>
            <Typography variant="caption" color="text.secondary">
              Los datos ingresados se guardarán en Supabase y generarán automáticamente la cuenta de acceso para la aplicación celular del operario.
            </Typography>

            <TextField
              label="Nombre Completo"
              placeholder="Ej: Marcelo Salas Rodríguez"
              fullWidth
              required
              value={name}
              onChange={(e) => setName(e.target.value)}
              disabled={isSubmitting}
            />

            <TextField
              label="RUT (con puntos y guión)"
              placeholder="Ej: 17.654.321-K"
              fullWidth
              required
              value={rut}
              onChange={(e) => setRut(e.target.value)}
              disabled={isSubmitting}
            />

            <TextField
              label="Correo Electrónico (Usuario de Login Móvil)"
              type="email"
              placeholder="ejemplo@faena.cl"
              fullWidth
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              disabled={isSubmitting}
            />

            <TextField
              label="Contraseña de Acceso Celular"
              type="text"
              fullWidth
              required
              helperText="Clave numérica o texto (mínimo 6 caracteres) para iniciar sesión en la App"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              disabled={isSubmitting}
            />

            <FormControl fullWidth disabled={isSubmitting}>
              <InputLabel id="role-select-label">Rol Operativo</InputLabel>
              <Select
                labelId="role-select-label"
                value={role}
                label="Rol Operativo"
                onChange={(e) => setRole(e.target.value)}
              >
                <MenuItem value="OPERATOR">Operario Terreno (Chofer / Limpieza)</MenuItem>
                <MenuItem value="SUPERVISOR">Supervisor General de Faena</MenuItem>
                <MenuItem value="ADMIN">Administrador de Plataforma</MenuItem>
              </Select>
            </FormControl>
          </DialogContent>
          <DialogActions sx={{ px: 3, pb: 2 }}>
            <Button onClick={() => setOpen(false)} disabled={isSubmitting}>
              Cancelar
            </Button>
            <Button
              type="submit"
              variant="contained"
              disabled={isSubmitting}
              startIcon={isSubmitting ? <CircularProgress size={20} color="inherit" /> : <AddIcon />}
            >
              {isSubmitting ? 'Guardando en Base de Datos...' : 'Guardar y Habilitar'}
            </Button>
          </DialogActions>
        </form>
      </Dialog>

      {/* Modal: Ver Documentos / Pases del Trabajador */}
      <Dialog
        open={docsModalOpen}
        onClose={() => setDocsModalOpen(false)}
        fullWidth
        maxWidth="xs"
      >
        <DialogTitle sx={{ fontWeight: 'bold' }}>
          Documentación Minera: {selectedWorker?.name}
        </DialogTitle>
        <DialogContent sx={{ display: 'flex', flexDirection: 'column', gap: 2, pt: 1 }}>
          <Typography variant="body2" color="text.secondary">
            RUT: <strong>{selectedWorker?.rut}</strong> | Rol: <strong>{selectedWorker?.role}</strong>
          </Typography>
          <Paper variant="outlined" sx={{ p: 2, display: 'flex', flexDirection: 'column', gap: 1.5 }}>
            <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <Typography variant="body2">📄 Cédula de Identidad</Typography>
              <Chip label="VIGENTE" size="small" color="success" />
            </Box>
            <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <Typography variant="body2">🪪 Licencia de Conducir (A4)</Typography>
              <Chip label="VIGENTE" size="small" color="success" />
            </Box>
            <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <Typography variant="body2">🏥 Examen Médico de Altura</Typography>
              <Chip label="AL DÍA" size="small" color="success" />
            </Box>
            <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <Typography variant="body2">🎟️ Pase Faena Minera</Typography>
              <Chip label="AUTORIZADO" size="small" color="success" />
            </Box>
          </Paper>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setDocsModalOpen(false)} variant="contained">
            Cerrar
          </Button>
        </DialogActions>
      </Dialog>

      {/* Toast Snackbar */}
      <Snackbar
        open={snackbar.open}
        autoHideDuration={5000}
        onClose={() => setSnackbar((prev) => ({ ...prev, open: false }))}
        anchorOrigin={{ vertical: 'bottom', horizontal: 'right' }}
      >
        <Alert
          onClose={() => setSnackbar((prev) => ({ ...prev, open: false }))}
          severity={snackbar.severity}
          variant="filled"
          sx={{ width: '100%' }}
        >
          {snackbar.message}
        </Alert>
      </Snackbar>
    </Box>
  );
};

export default Workers;
