import React, { useState, useEffect } from 'react';
import api from '../core/api';
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

export const Workers: React.FC = () => {
  const [workers, setWorkers] = useState<Worker[]>([]);
  const [open, setOpen] = useState(false);
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [rut, setRut] = useState('');
  const [role, setRole] = useState('OPERATOR');

  const fetchWorkers = async () => {
    try {
      const response = await api.get('/api/v1/workers/list');
      setWorkers(response.data);
    } catch (_) {
      // Fallback
      setWorkers([
        {
          id: 'worker-1',
          name: 'Juan Pérez Díaz',
          rut: '12.345.678-9',
          email: 'worker@demo.com',
          role: 'OPERATOR',
          status: 'ACTIVE',
        },
        {
          id: 'worker-2',
          name: 'Carlos Muñoz Soto',
          rut: '15.987.654-3',
          email: 'carlos@demo.com',
          role: 'OPERATOR',
          status: 'BLOCKED',
        },
      ]);
    }
  };

  useEffect(() => {
    fetchWorkers();
  }, []);

  const handleCreate = async () => {
    try {
      await api.post('/api/v1/workers/create', { name, email, rut, role });
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
            label="Correo Electrónico"
            type="email"
            fullWidth
            required
            value={email}
            onChange={(e) => setEmail(e.target.value)}
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
