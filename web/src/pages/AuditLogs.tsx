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
  Chip,
  Button,
} from '@mui/material';
import MapIcon from '@mui/icons-material/Map';

interface AuditLog {
  id: string;
  action: string; // WORKER_BLOCK, VEHICLE_BLOCK, CHECKLIST_CRITICAL_FAIL
  timestamp: string;
  gpsLat: number;
  gpsLon: number;
  payload: string;
}

export const AuditLogs: React.FC = () => {
  const [logs, setLogs] = useState<AuditLog[]>([]);

  const fetchLogs = async () => {
    try {
      const response = await api.get('/api/v1/audit/logs');
      setLogs(response.data);
    } catch (_) {
      // Fallback
      setLogs([
        {
          id: 'audit-1',
          action: 'WORKER_DOCUMENT_EXPIRED',
          timestamp: new Date(Date.now() - 3600000).toISOString(),
          gpsLat: -24.2713,
          gpsLon: -69.0664,
          payload: JSON.stringify({
            reason: 'El trabajador Juan Pérez intentó ingresar con Pase de Faena vencido (vencimiento: 2026-08-01).',
          }),
        },
        {
          id: 'audit-2',
          action: 'CHECKLIST_CRITICAL_FAIL',
          timestamp: new Date(Date.now() - 7200000).toISOString(),
          gpsLat: -24.2745,
          gpsLon: -69.0620,
          payload: JSON.stringify({
            reason: 'Camión Patente DX-9002 reportó "NO" en dirección e inspección de frenos.',
          }),
        },
      ]);
    }
  };

  useEffect(() => {
    fetchLogs();
  }, []);

  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', gap: 3 }}>
      <Typography variant="h5" sx={{ fontWeight: 'bold' }}>
        Registro de Auditoría e Incidentes Operacionales
      </Typography>

      <Card>
        <TableContainer component={Paper} elevation={0}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>ID de Auditoría</TableCell>
                <TableCell>Tipo Incidente</TableCell>
                <TableCell>Fecha / Hora</TableCell>
                <TableCell>Ubicación GPS</TableCell>
                <TableCell>Causa del Bloqueo / Detalle</TableCell>
                <TableCell align="right">Acciones</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {logs.map((log) => {
                let reason = '';
                try {
                  reason = JSON.parse(log.payload).reason || '';
                } catch (_) {
                  reason = log.payload;
                }

                return (
                  <TableRow key={log.id}>
                    <TableCell style={{ fontSize: 12, fontFamily: 'monospace' }}>{log.id}</TableCell>
                    <TableCell>
                      <Chip
                        label={log.action}
                        color={log.action.includes('EXPIRED') || log.action.includes('FAIL') ? 'error' : 'warning'}
                        size="small"
                      />
                    </TableCell>
                    <TableCell>{new Date(log.timestamp).toLocaleString()}</TableCell>
                    <TableCell>
                      {log.gpsLat.toFixed(5)}, {log.gpsLon.toFixed(5)}
                    </TableCell>
                    <TableCell style={{ fontSize: 13, maxWidth: 350 }}>{reason}</TableCell>
                    <TableCell align="right">
                      <Button
                        startIcon={<MapIcon />}
                        size="small"
                        color="secondary"
                        onClick={() => {
                          window.open(`https://www.google.com/maps?q=${log.gpsLat},${log.gpsLon}`, '_blank');
                        }}
                      >
                        Ver Mapa
                      </Button>
                    </TableCell>
                  </TableRow>
                );
              })}
            </TableBody>
          </Table>
        </TableContainer>
      </Card>
    </Box>
  );
};
export default AuditLogs;
