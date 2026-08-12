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
} from '@mui/material';
import AddIcon from '@mui/icons-material/Add';
import QrCodeIcon from '@mui/icons-material/QrCode';

interface Vehicle {
  id: string;
  plateNumber: string;
  brand: string;
  model: string;
  year: number;
  lastOdometer: number;
  isActive: boolean;
}

export const Vehicles: React.FC = () => {
  const [vehicles, setVehicles] = useState<Vehicle[]>([]);
  const [open, setOpen] = useState(false);
  const [plateNumber, setPlateNumber] = useState('');
  const [brand, setBrand] = useState('');
  const [model, setModel] = useState('');
  const [year, setYear] = useState(2022);
  const [odometer, setOdometer] = useState(10000);

  const fetchVehicles = async () => {
    try {
      const response = await api.get('/api/v1/vehicles/list');
      setVehicles(response.data);
    } catch (_) {
      // Fallback
      setVehicles([
        {
          id: 'vehicle-1',
          plateNumber: 'DX-9002',
          brand: 'Mercedes-Benz',
          model: 'Actros',
          year: 2021,
          lastOdometer: 145000,
          isActive: true,
        },
        {
          id: 'vehicle-2',
          plateNumber: 'CH-4010',
          brand: 'Volvo',
          model: 'FMX',
          year: 2020,
          lastOdometer: 198000,
          isActive: false,
        },
      ]);
    }
  };

  useEffect(() => {
    fetchVehicles();
  }, []);

  const handleCreate = async () => {
    try {
      await api.post('/api/v1/vehicles/create', { plateNumber, brand, model, year, lastOdometer: odometer });
      setOpen(false);
      fetchVehicles();
      setPlateNumber('');
      setBrand('');
      setModel('');
    } catch (_) {
      setVehicles((prev) => [
        ...prev,
        {
          id: `vehicle-${Date.now()}`,
          plateNumber,
          brand,
          model,
          year,
          lastOdometer: odometer,
          isActive: true,
        },
      ]);
      setOpen(false);
    }
  };

  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', gap: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <Typography variant="h5" sx={{ fontWeight: 'bold' }}>
          Gestión de Vehículos y Camiones de Limpieza
        </Typography>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={() => setOpen(true)}
        >
          REGISTRAR VEHÍCULO
        </Button>
      </Box>

      <Card>
        <TableContainer component={Paper} elevation={0}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Patente</TableCell>
                <TableCell>Marca / Modelo</TableCell>
                <TableCell>Año</TableCell>
                <TableCell>Último Kilometraje (KM)</TableCell>
                <TableCell>Estado Técnico</TableCell>
                <TableCell align="right">Acciones</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {vehicles.map((v) => (
                <TableRow key={v.id}>
                  <TableCell style={{ fontWeight: 'bold' }}>{v.plateNumber}</TableCell>
                  <TableCell>{v.brand} {v.model}</TableCell>
                  <TableCell>{v.year}</TableCell>
                  <TableCell>{v.lastOdometer.toLocaleString()} KM</TableCell>
                  <TableCell>
                    <Chip
                      label={v.isActive ? 'OPERATIVO' : 'FUERA DE SERVICIO'}
                      color={v.isActive ? 'success' : 'error'}
                      size="small"
                    />
                  </TableCell>
                  <TableCell align="right">
                    <Button
                      startIcon={<QrCodeIcon />}
                      size="small"
                      color="secondary"
                    >
                      Ver QR
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
        <DialogTitle sx={{ fontWeight: 'bold' }}>Registrar Nuevo Vehículo</DialogTitle>
        <DialogContent sx={{ display: 'flex', flexDirection: 'column', gap: 3, mt: 1 }}>
          <TextField
            label="Patente (Ej. DX-9002)"
            fullWidth
            required
            value={plateNumber}
            onChange={(e) => setPlateNumber(e.target.value)}
          />
          <TextField
            label="Marca"
            fullWidth
            required
            value={brand}
            onChange={(e) => setBrand(e.target.value)}
          />
          <TextField
            label="Modelo"
            fullWidth
            required
            value={model}
            onChange={(e) => setModel(e.target.value)}
          />
          <TextField
            label="Año"
            type="number"
            fullWidth
            required
            value={year}
            onChange={(e) => setYear(Number(e.target.value))}
          />
          <TextField
            label="Kilometraje de Inicio"
            type="number"
            fullWidth
            required
            value={odometer}
            onChange={(e) => setOdometer(Number(e.target.value))}
          />
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
export default Vehicles;
