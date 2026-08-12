import React, { useState, useEffect } from 'react';
import api from '../core/api';
import {
  Grid,
  Card,
  CardContent,
  Typography,
  Box,
  LinearProgress,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Chip,
  Avatar,
} from '@mui/material';
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
} from 'recharts';
import PeopleIcon from '@mui/icons-material/People';
import DirectionsCarIcon from '@mui/icons-material/DirectionsCar';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import WarningAmberIcon from '@mui/icons-material/WarningAmber';

interface KPIData {
  workersCount: number;
  vehiclesCount: number;
  complianceRate: number;
  alertsCount: number;
}

interface AlertLog {
  id: string;
  action: string;
  timestamp: string;
  gpsLat: number;
  gpsLon: number;
  payload: string;
}

export const Dashboard: React.FC = () => {
  const [kpis, setKpis] = useState<KPIData>({
    workersCount: 8,
    vehiclesCount: 4,
    complianceRate: 92.5,
    alertsCount: 1,
  });
  const [alerts, setAlerts] = useState<AlertLog[]>([]);

  useEffect(() => {
    const fetchDashboardData = async () => {
      try {
        const kpiResponse = await api.get('/api/v1/audit/kpis');
        setKpis(kpiResponse.data);
      } catch (_) {
        // Fallback
      }

      try {
        const alertsResponse = await api.get('/api/v1/audit/alerts');
        setAlerts(alertsResponse.data);
      } catch (_) {
        setAlerts([
          {
            id: 'alert-1',
            action: 'CHECKLIST_CRITICAL_FAIL',
            timestamp: new Date().toISOString(),
            gpsLat: -24.2713,
            gpsLon: -69.0664,
            payload: JSON.stringify({
              reason: 'Frenos en mal estado detectados en camión Patente DX-9002 durante checklist pre-operacional.',
            }),
          },
        ]);
      }
    };
    fetchDashboardData();
  }, []);

  const chartData = [
    { name: 'Lun', Rutas: 5, Completadas: 4 },
    { name: 'Mar', Rutas: 6, Completadas: 6 },
    { name: 'Mie', Rutas: 8, Completadas: 7 },
    { name: 'Jue', Rutas: 7, Completadas: 6 },
    { name: 'Vie', Rutas: 9, Completadas: 9 },
    { name: 'Sab', Rutas: 4, Completadas: 3 },
    { name: 'Dom', Rutas: 3, Completadas: 3 },
  ];

  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', gap: 4 }}>
      {/* Tarjetas de Indicadores Clave (KPIs) */}
      <Grid container spacing={3}>
        <Grid size={{ xs: 12, sm: 6, md: 3 }}>
          <Card>
            <CardContent sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
              <Box>
                <Typography variant="body2" sx={{ color: 'text.secondary', fontWeight: 'bold' }}>
                  TRABAJADORES ACTIVO
                </Typography>
                <Typography variant="h3" sx={{ fontWeight: 'bold', mt: 1 }}>
                  {kpis.workersCount}
                </Typography>
              </Box>
              <Avatar sx={{ bgcolor: 'primary.dark', width: 56, height: 56 }}>
                <PeopleIcon fontSize="large" color="primary" />
              </Avatar>
            </CardContent>
          </Card>
        </Grid>

        <Grid size={{ xs: 12, sm: 6, md: 3 }}>
          <Card>
            <CardContent sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
              <Box>
                <Typography variant="body2" sx={{ color: 'text.secondary', fontWeight: 'bold' }}>
                  VEHÍCULOS EN OPERACIÓN
                </Typography>
                <Typography variant="h3" sx={{ fontWeight: 'bold', mt: 1 }}>
                  {kpis.vehiclesCount}
                </Typography>
              </Box>
              <Avatar sx={{ bgcolor: 'secondary.dark', width: 56, height: 56 }}>
                <DirectionsCarIcon fontSize="large" color="secondary" />
              </Avatar>
            </CardContent>
          </Card>
        </Grid>

        <Grid size={{ xs: 12, sm: 6, md: 3 }}>
          <Card>
            <CardContent sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
              <Box>
                <Typography variant="body2" sx={{ color: 'text.secondary', fontWeight: 'bold' }}>
                  TASA CUMPLIMIENTO
                </Typography>
                <Typography variant="h3" sx={{ fontWeight: 'bold', color: 'success.main', mt: 1 }}>
                  {kpis.complianceRate}%
                </Typography>
              </Box>
              <Avatar sx={{ bgcolor: 'success.main', width: 56, height: 56 }}>
                <CheckCircleIcon fontSize="large" sx={{ color: 'white' }} />
              </Avatar>
            </CardContent>
          </Card>
        </Grid>

        <Grid size={{ xs: 12, sm: 6, md: 3 }}>
          <Card sx={{ bgcolor: kpis.alertsCount > 0 ? 'rgba(239, 68, 68, 0.1)' : 'transparent' }}>
            <CardContent sx={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
              <Box>
                <Typography variant="body2" sx={{ color: 'text.secondary', fontWeight: 'bold' }}>
                  BLOQUEOS Y ALERTAS
                </Typography>
                <Typography variant="h3" sx={{ fontWeight: 'bold', color: 'error.main', mt: 1 }}>
                  {kpis.alertsCount}
                </Typography>
              </Box>
              <Avatar sx={{ bgcolor: 'error.main', width: 56, height: 56 }}>
                <WarningAmberIcon fontSize="large" sx={{ color: 'white' }} />
              </Avatar>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      {/* Gráficos de Gestión */}
      <Grid container spacing={3}>
        <Grid size={{ xs: 12, md: 8 }}>
          <Card sx={{ p: 2 }}>
            <Typography variant="h6" sx={{ fontWeight: 'bold', mb: 3 }}>
              Cumplimiento de Rutas Semanal
            </Typography>
            <Box sx={{ height: 300 }}>
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={chartData}>
                  <CartesianGrid strokeDasharray="3 3" opacity={0.1} />
                  <XAxis dataKey="name" />
                  <YAxis />
                  <Tooltip />
                  <Bar dataKey="Rutas" fill="#1e293b" stroke="#3b82f6" strokeWidth={1} />
                  <Bar dataKey="Completadas" fill="#10b981" />
                </BarChart>
              </ResponsiveContainer>
            </Box>
          </Card>
        </Grid>

        <Grid size={{ xs: 12, md: 4 }}>
          <Card sx={{ p: 2, height: '100%' }}>
            <Typography variant="h6" sx={{ fontWeight: 'bold', mb: 3 }}>
              Estado General de Faena
            </Typography>
            <Box sx={{ display: 'flex', flexDirection: 'column', gap: 3 }}>
              <Box>
                <Typography variant="body2" sx={{ color: 'text.secondary', mb: 1 }}>
                  Rendimiento Diario
                </Typography>
                <LinearProgress variant="determinate" value={85} color="primary" sx={{ height: 8, borderRadius: 4 }} />
              </Box>
              <Box>
                <Typography variant="body2" sx={{ color: 'text.secondary', mb: 1 }}>
                  Checklists Aprobados
                </Typography>
                <LinearProgress variant="determinate" value={95} color="success" sx={{ height: 8, borderRadius: 4 }} />
              </Box>
              <Box>
                <Typography variant="body2" sx={{ color: 'text.secondary', mb: 1 }}>
                  Incidencias Mecánicas
                </Typography>
                <LinearProgress variant="determinate" value={5} color="error" sx={{ height: 8, borderRadius: 4 }} />
              </Box>
            </Box>
          </Card>
        </Grid>
      </Grid>

      {/* Recientes Alertas de Bloqueo */}
      <Card sx={{ p: 2 }}>
        <Typography variant="h6" sx={{ fontWeight: 'bold', mb: 3, color: 'error.main' }}>
          Últimas Alertas de Bloqueo (Trazabilidad RLS)
        </Typography>
        <TableContainer component={Paper} elevation={0}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Tipo Alerta</TableCell>
                <TableCell>Fecha / Hora</TableCell>
                <TableCell>Coordenadas GPS</TableCell>
                <TableCell>Detalle e Incidencia</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {alerts.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={4} align="center">
                    No se registran alertas operacionales en faena hoy.
                  </TableCell>
                </TableRow>
              ) : (
                alerts.map((alert) => {
                  const payloadObj = JSON.parse(alert.payload);
                  return (
                    <TableRow key={alert.id}>
                      <TableCell>
                        <Chip label={alert.action} color="error" size="small" />
                      </TableCell>
                      <TableCell>{new Date(alert.timestamp).toLocaleString()}</TableCell>
                      <TableCell>
                        {alert.gpsLat.toFixed(4)}, {alert.gpsLon.toFixed(4)}
                      </TableCell>
                      <TableCell>{payloadObj.reason}</TableCell>
                    </TableRow>
                  );
                })
              )}
            </TableBody>
          </Table>
        </TableContainer>
      </Card>
    </Box>
  );
};
export default Dashboard;
