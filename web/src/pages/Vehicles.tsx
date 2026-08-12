import React, { useState, useEffect } from 'react';
import api from '../core/api';
import { supabase, DEFAULT_TENANT_ID } from '../core/supabaseClient';
import { QRCodeSVG } from 'qrcode.react';
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
  IconButton,
  Tooltip,
  CircularProgress,
} from '@mui/material';
import AddIcon from '@mui/icons-material/Add';
import QrCodeIcon from '@mui/icons-material/QrCode';
import RefreshIcon from '@mui/icons-material/Refresh';

interface Vehicle {
  id: string;
  plateNumber: string;
  brand: string;
  model: string;
  year: number;
  lastOdometer: number;
  qrCodeToken: string;
  isActive: boolean;
}

export const Vehicles: React.FC = () => {
  const [vehicles, setVehicles] = useState<Vehicle[]>([]);
  const [loading, setLoading] = useState(false);
  const [open, setOpen] = useState(false);
  const [qrModalOpen, setQrModalOpen] = useState(false);
  const [selectedVehicleForQR, setSelectedVehicleForQR] = useState<Vehicle | null>(null);

  // Form fields
  const [plateNumber, setPlateNumber] = useState('');
  const [brand, setBrand] = useState('');
  const [model, setModel] = useState('');
  const [year, setYear] = useState(2022);
  const [odometer, setOdometer] = useState(10000);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const fetchVehicles = async () => {
    setLoading(true);
    try {
      // 1. Consultar primero a la base de datos Supabase
      const { data, error } = await supabase
        .from('vehicles')
        .select('*')
        .eq('tenant_id', DEFAULT_TENANT_ID)
        .order('created_at', { ascending: false });

      if (!error && data && data.length > 0) {
        setVehicles(
          data.map((v: any) => ({
            id: v.id,
            plateNumber: v.plate_number,
            brand: v.brand,
            model: v.model,
            year: v.year,
            lastOdometer: v.last_odometer ?? 0,
            qrCodeToken: v.qr_code_token || `CAMION-${(v.plate_number || '').toUpperCase().replace(/\s+/g, '')}`,
            isActive: v.is_active ?? true,
          }))
        );
        setLoading(false);
        return;
      }

      // 2. Intentar backend NestJS
      const response = await api.get('/api/v1/vehicles/list');
      if (response?.data && Array.isArray(response.data) && response.data.length > 0) {
        setVehicles(
          response.data.map((v: any) => ({
            id: v.id,
            plateNumber: v.plateNumber || v.plate_number,
            brand: v.brand,
            model: v.model,
            year: v.year,
            lastOdometer: v.lastOdometer ?? v.last_odometer ?? 0,
            qrCodeToken: v.qrCodeToken || v.qr_code_token || `CAMION-${(v.plateNumber || v.plate_number || '').toUpperCase().replace(/\s+/g, '')}`,
            isActive: v.isActive ?? v.is_active ?? true,
          }))
        );
        setLoading(false);
        return;
      }
    } catch (_) {
      // Fallback
    }

    // 3. Fallback demo
    setVehicles([
      {
        id: 'vehicle-1',
        plateNumber: 'DX-9002',
        brand: 'Mercedes-Benz',
        model: 'Actros',
        year: 2021,
        lastOdometer: 145000,
        qrCodeToken: 'CAMION-DX9002',
        isActive: true,
      },
      {
        id: 'vehicle-2',
        plateNumber: 'CH-4010',
        brand: 'Volvo',
        model: 'FMX',
        year: 2020,
        lastOdometer: 198000,
        qrCodeToken: 'CAMION-CH4010',
        isActive: false,
      },
    ]);
    setLoading(false);
  };

  useEffect(() => {
    fetchVehicles();
  }, []);

  const handleCreate = async () => {
    if (!plateNumber.trim() || !brand.trim() || !model.trim()) return;

    setIsSubmitting(true);
    const cleanPlate = plateNumber.trim().toUpperCase().replace(/\s+/g, '');
    const qrToken = `CAMION-${cleanPlate}`;

    try {
      // 1. Insertar en la tabla vehicles de Supabase
      const { data, error } = await supabase
        .from('vehicles')
        .insert([
          {
            tenant_id: DEFAULT_TENANT_ID,
            plate_number: plateNumber.trim().toUpperCase(),
            brand: brand.trim(),
            model: model.trim(),
            year: Number(year),
            last_odometer: Number(odometer),
            qr_code_token: qrToken,
            is_active: true,
          },
        ])
        .select();

      if (error) {
        throw error;
      }

      if (data && data.length > 0) {
        const newV = data[0];
        setVehicles((prev) => [
          {
            id: newV.id,
            plateNumber: newV.plate_number,
            brand: newV.brand,
            model: newV.model,
            year: newV.year,
            lastOdometer: newV.last_odometer ?? 0,
            qrCodeToken: newV.qr_code_token,
            isActive: newV.is_active ?? true,
          },
          ...prev,
        ]);
      } else {
        await fetchVehicles();
      }

      setOpen(false);
      setPlateNumber('');
      setBrand('');
      setModel('');
      setYear(2022);
      setOdometer(10000);
    } catch (_) {
      // Fallback local
      setVehicles((prev) => [
        ...prev,
        {
          id: `vehicle-${Date.now()}`,
          plateNumber: plateNumber.trim().toUpperCase(),
          brand: brand.trim(),
          model: model.trim(),
          year: Number(year),
          lastOdometer: Number(odometer),
          qrCodeToken: qrToken,
          isActive: true,
        },
      ]);
      setOpen(false);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleOpenQR = (vehicle: Vehicle) => {
    setSelectedVehicleForQR(vehicle);
    setQrModalOpen(true);
  };

  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', gap: 3 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: 2 }}>
        <div>
          <Typography variant="h5" sx={{ fontWeight: 'bold' }}>
            Gestión de Vehículos y Camiones de Limpieza
          </Typography>
          <Typography variant="body2" color="text.secondary">
            Administra la flota de camiones de extracción y genera sus códigos QR de validación en faena.
          </Typography>
        </div>
        <Box sx={{ display: 'flex', gap: 1 }}>
          <Tooltip title="Recargar lista">
            <IconButton onClick={fetchVehicles} disabled={loading} color="primary">
              {loading ? <CircularProgress size={24} /> : <RefreshIcon />}
            </IconButton>
          </Tooltip>
          <Button
            variant="contained"
            startIcon={<AddIcon />}
            onClick={() => setOpen(true)}
            sx={{ fontWeight: 'bold' }}
          >
            REGISTRAR VEHÍCULO
          </Button>
        </Box>
      </Box>

      <Card>
        <TableContainer component={Paper} elevation={0}>
          <Table>
            <TableHead sx={{ backgroundColor: 'action.hover' }}>
              <TableRow>
                <TableCell sx={{ fontWeight: 'bold' }}>Patente</TableCell>
                <TableCell sx={{ fontWeight: 'bold' }}>Marca / Modelo</TableCell>
                <TableCell sx={{ fontWeight: 'bold' }}>Año</TableCell>
                <TableCell sx={{ fontWeight: 'bold' }}>Último Kilometraje (KM)</TableCell>
                <TableCell sx={{ fontWeight: 'bold' }}>Estado Técnico</TableCell>
                <TableCell align="right" sx={{ fontWeight: 'bold' }}>Acciones</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {vehicles.map((v) => (
                <TableRow key={v.id} hover>
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
                      variant="outlined"
                      color="secondary"
                      onClick={() => handleOpenQR(v)}
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

      {/* Diálogo de Registro de Vehículo */}
      <Dialog open={open} onClose={() => !isSubmitting && setOpen(false)} fullWidth maxWidth="xs">
        <DialogTitle sx={{ fontWeight: 'bold' }}>Registrar Nuevo Vehículo</DialogTitle>
        <DialogContent sx={{ display: 'flex', flexDirection: 'column', gap: 2.5, mt: 1 }}>
          <TextField
            label="Patente (Ej. DX-9002)"
            fullWidth
            required
            value={plateNumber}
            onChange={(e) => setPlateNumber(e.target.value)}
            disabled={isSubmitting}
          />
          <TextField
            label="Marca"
            placeholder="Ej. Mercedes-Benz, Volvo, Scania"
            fullWidth
            required
            value={brand}
            onChange={(e) => setBrand(e.target.value)}
            disabled={isSubmitting}
          />
          <TextField
            label="Modelo"
            placeholder="Ej. Actros 2644, FMX 460"
            fullWidth
            required
            value={model}
            onChange={(e) => setModel(e.target.value)}
            disabled={isSubmitting}
          />
          <TextField
            label="Año"
            type="number"
            fullWidth
            required
            value={year}
            onChange={(e) => setYear(Number(e.target.value))}
            disabled={isSubmitting}
          />
          <TextField
            label="Kilometraje de Inicio"
            type="number"
            fullWidth
            required
            value={odometer}
            onChange={(e) => setOdometer(Number(e.target.value))}
            disabled={isSubmitting}
          />
        </DialogContent>
        <DialogActions sx={{ px: 3, pb: 2 }}>
          <Button onClick={() => setOpen(false)} disabled={isSubmitting}>
            Cancelar
          </Button>
          <Button
            onClick={handleCreate}
            variant="contained"
            disabled={isSubmitting || !plateNumber.trim()}
          >
            {isSubmitting ? 'Guardando...' : 'Registrar'}
          </Button>
        </DialogActions>
      </Dialog>

      {/* Diálogo: Ver Código QR del Vehículo */}
      <Dialog
        open={qrModalOpen}
        onClose={() => setQrModalOpen(false)}
        maxWidth="xs"
        fullWidth
      >
        <DialogTitle sx={{ fontWeight: 'bold', textAlign: 'center', pb: 1 }}>
          Código QR de Validación
        </DialogTitle>
        <DialogContent sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 2, pt: 2 }}>
          {selectedVehicleForQR && (
            <>
              <Box sx={{ p: 2, bgcolor: '#ffffff', borderRadius: 2, boxShadow: '0px 2px 10px rgba(0,0,0,0.1)', display: 'inline-flex' }}>
                <QRCodeSVG
                  value={selectedVehicleForQR.qrCodeToken}
                  size={200}
                  level="H"
                  includeMargin={true}
                />
              </Box>
              <Typography variant="h6" sx={{ fontWeight: 'bold', mt: 1 }} align="center">
                {selectedVehicleForQR.brand} {selectedVehicleForQR.model} ({selectedVehicleForQR.year})
              </Typography>
              <Typography variant="body2" color="text.secondary">
                Patente: <strong>{selectedVehicleForQR.plateNumber}</strong>
              </Typography>
              <Chip
                label={`Token: ${selectedVehicleForQR.qrCodeToken}`}
                color="primary"
                variant="outlined"
                sx={{ fontFamily: 'monospace', fontWeight: 'bold', fontSize: 13 }}
              />
              <Typography variant="caption" color="text.secondary" align="center" sx={{ px: 2 }}>
                Imprime o muestra este código QR para que el conductor o personal de faena lo escanee con la cámara de la aplicación móvil.
              </Typography>
            </>
          )}
        </DialogContent>
        <DialogActions sx={{ justifyContent: 'center', pb: 2 }}>
          <Button onClick={() => setQrModalOpen(false)} variant="contained">
            Cerrar
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default Vehicles;
