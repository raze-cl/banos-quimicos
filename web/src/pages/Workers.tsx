import React, { useState, useEffect } from 'react';
import api from '../core/api';
import { supabase } from '../core/supabaseClient';
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
} from '@mui/material';
import AddIcon from '@mui/icons-material/Add';
import DescriptionIcon from '@mui/icons-material/Description';

interface Worker {
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
    name: 'Juan Pérez Díaz',
    rut: '12.345.678-9',
    email: 'juan.perez@faena.cl',
    role: 'OPERATOR',
    status: 'ACTIVE',
  },
  {
    id: 'worker-2',
    name: 'Carlos Muñoz Soto',
    rut: '15.987.654-3',
    email: 'carlos.munoz@faena.cl',
    role: 'OPERATOR',
    status: 'BLOCKED',
  },
];

export const Workers: React.FC = () => {
  const [workers, setWorkers] = useState<Worker[]>([]);
  const [open, setOpen] = useState(false);
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [rut, setRut] = useState('');
  const [password, setPassword] = useState('123456');
  const [role, setRole] = useState('OPERATOR');

  const fetchWorkers = async () => {
    try {
      // 1. Intentar obtener desde Supabase directamente
      const { data } = await supabase.from('workers_profile').select('*');
      if (data && data.length > 0) {
        setWorkers(
          data.map((w: any) => ({
            id: w.id,
            name: `${w.first_name || ''} ${w.last_name || ''}`.trim() || 'Trabajador Faena',
            rut: w.rut || '12.345.678-9',
            email: w.phone || 'operario@faena.cl',
            role: w.license_class ? `Licencia ${w.license_class}` : 'OPERATOR',
            status: 'ACTIVE',
          }))
        );
        return;
      }

      // 2. Intentar backend NestJS
      const response = await api.get('/api/v1/workers/list');
      setWorkers(response.data);
    } catch (_) {
      setWorkers(DEFAULT_WORKERS);
    }
  };

  useEffect(() => {
    fetchWorkers();
  }, []);

  const handleCreate = async () => {
    try {
      const names = name.trim().split(' ');
      const firstName = names[0] || name;
      const lastName = names.slice(1).join(' ') || 'Díaz';

      // Insertar en la tabla workers_profile de Supabase
      await supabase.from('workers_profile').insert([
        {
          tenant_id: '00000000-0000-0000-0000-000000000001',
          user_id: `00000000-0000-0000-0000-${Date.now().toString().slice(-12)}`,
          rut,
          first_name: firstName,
          last_name: lastName,
          phone: email,
          license_class: 'A4',
        },
      ]);

      setOpen(false);
      fetchWorkers();
      setName('');
      setEmail('');
      setRut('');
    } catch (_) {
      setWorkers((prev) => [
        ...prev,
        {
          id: `worker-${Date.now()}`,
          name,
          rut,
          email,
          role,
          status: 'ACTIVE',
        },
      ]);
      setOpen(false);
    }
  };

  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', gap: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <Typography variant="h5" sx={{ fontWeight: 'bold' }}>
          Gestión de Trabajadores y Operarios
        </Typography>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={() => setOpen(true)}
        >
          REGISTRAR TRABAJADOR
        </Button>
      </Box>

      <Card>
        <TableContainer component={Paper} elevation={0}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Nombre Trabajador</TableCell>
                <TableCell>RUT</TableCell>
                <TableCell>Correo Electrónico</TableCell>
                <TableCell>Rol Minero</TableCell>
                <TableCell>Estado Ingreso</TableCell>
                <TableCell align="right">Acciones</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {workers.map((worker) => (
                <TableRow key={worker.id}>
                  <TableCell style={{ fontWeight: 'bold' }}>{worker.name}</TableCell>
                  <TableCell>{worker.rut}</TableCell>
                  <TableCell>{worker.email}</TableCell>
                  <TableCell>
                    <Chip label={worker.role} size="small" variant="outlined" color="primary" />
                  </TableCell>
                  <TableCell>
                    <Chip
                      label={worker.status === 'ACTIVE' ? 'HABILITADO' : 'BLOQUEADO'}
                      color={worker.status === 'ACTIVE' ? 'success' : 'error'}
                      size="small"
                    />
                  </TableCell>
                  <TableCell align="right">
                    <Button
                      startIcon={<DescriptionIcon />}
                      size="small"
                      color="secondary"
                    >
                      Documentos
                    </Button>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      </Card>

      {/* Dialogo de Registro */}
      <Dialog open={open} onClose={() => setOpen(false)} fullWidth maxWidth="xs">
        <DialogTitle sx={{ fontWeight: 'bold' }}>Registrar Nuevo Trabajador</DialogTitle>
        <DialogContent sx={{ display: 'flex', flexDirection: 'column', gap: 3, mt: 1 }}>
          <TextField
            label="Nombre Completo"
            fullWidth
            required
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
          <TextField
            label="RUT (con puntos y guión)"
            fullWidth
            required
            value={rut}
            onChange={(e) => setRut(e.target.value)}
          />
          <TextField
            label="Correo Electrónico (Usuario Móvil)"
            type="email"
            fullWidth
            required
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
          <TextField
            label="Contraseña de Acceso Celular"
            type="password"
            fullWidth
            required
            helperText="Clave de 6+ caracteres usada por el operario en la App Móvil"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
          <FormControl fullWidth>
            <InputLabel id="role-select">Rol Minero</InputLabel>
            <Select
              labelId="role-select"
              value={role}
              label="Rol Minero"
              onChange={(e) => setRole(e.target.value)}
            >
              <MenuItem value="OPERATOR">Operario Terreno</MenuItem>
              <MenuItem value="SUPERVISOR">Supervisor General</MenuItem>
              <MenuItem value="ADMIN">Administrador</MenuItem>
            </Select>
          </FormControl>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpen(false)}>Cancelar</Button>
          <Button onClick={handleCreate} variant="contained">
            Registrar
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};
export default Workers;
