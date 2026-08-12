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
  Tabs,
  Tab,
  IconButton,
  FormControlLabel,
  Switch,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
  Tooltip,
  Divider,
  List,
  ListItem,
  ListItemText,
  Badge,
} from '@mui/material';
import AddIcon from '@mui/icons-material/Add';
import TuneIcon from '@mui/icons-material/Tune';
import DeleteIcon from '@mui/icons-material/Delete';
import WarningAmberIcon from '@mui/icons-material/WarningAmber';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import LocationOnIcon from '@mui/icons-material/LocationOn';
import VisibilityIcon from '@mui/icons-material/Visibility';
import AssignmentCheckIcon from '@mui/icons-material/AssignmentTurnedIn';

interface Question {
  id: string;
  questionText: string;
  questionType: 'YES_NO' | 'TEXT' | 'PHOTO' | 'MULTIPLE_CHOICE';
  isRequired: boolean;
  isCritical: boolean;
}

interface ChecklistTemplate {
  id: string;
  title: string;
  description: string;
  version: number;
  isActive: boolean;
  questions: Question[];
}

interface ChecklistSubmission {
  id: string;
  workerName: string;
  workerEmail: string;
  vehiclePlate: string;
  checklistTitle: string;
  submittedAt: string;
  gpsLat: number;
  gpsLon: number;
  hasCriticalFailure: boolean;
  answers: {
    questionText: string;
    answerValue: string;
    isCritical: boolean;
    photoUrl?: string;
  }[];
}

export const Checklists: React.FC = () => {
  const [activeTab, setActiveTab] = useState(0);

  // Estados de Plantillas
  const [templates, setTemplates] = useState<ChecklistTemplate[]>([]);
  const [openNewDialog, setOpenNewDialog] = useState(false);
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');

  // Estados de Diseñador de Preguntas
  const [selectedTemplate, setSelectedTemplate] = useState<ChecklistTemplate | null>(null);
  const [openDesigner, setOpenDesigner] = useState(false);
  const [newQuestionText, setNewQuestionText] = useState('');
  const [newQuestionType, setNewQuestionType] = useState<'YES_NO' | 'TEXT' | 'PHOTO' | 'MULTIPLE_CHOICE'>('YES_NO');
  const [newIsRequired, setNewIsRequired] = useState(true);
  const [newIsCritical, setNewIsCritical] = useState(false);

  // Estados de Respuestas de Terreno
  const [submissions, setSubmissions] = useState<ChecklistSubmission[]>([]);
  const [selectedSubmission, setSelectedSubmission] = useState<ChecklistSubmission | null>(null);
  const [openSubmissionDetail, setOpenSubmissionDetail] = useState(false);

  const fetchTemplates = async () => {
    try {
      const response = await api.get('/api/v1/checklists/templates');
      setTemplates(response.data);
    } catch (_) {
      // Plantillas predeterminadas de demostración
      setTemplates([
        {
          id: 'chk-fatiga',
          title: 'Fatiga y Somnolencia',
          description: 'Autoevaluación del estado de alerta y descanso previo a la jornada.',
          version: 1,
          isActive: true,
          questions: [
            { id: 'q1', questionText: '¿Durmió al menos 7 horas continuas antes del turno?', questionType: 'YES_NO', isRequired: true, isCritical: true },
            { id: 'q2', questionText: '¿Se encuentra tomando algún medicamento que produzca somnolencia?', questionType: 'YES_NO', isRequired: true, isCritical: true },
            { id: 'q3', questionText: 'Indique su nivel de energía actual (1 a 5)', questionType: 'TEXT', isRequired: true, isCritical: false },
          ],
        },
        {
          id: 'chk-equipo',
          title: 'Estado del Camión / Equipo',
          description: 'Inspección pre-operacional de luces, frenos y niveles.',
          version: 1,
          isActive: true,
          questions: [
            { id: 'q4', questionText: '¿Frenos de servicio y de mano funcionando correctamente?', questionType: 'YES_NO', isRequired: true, isCritical: true },
            { id: 'q5', questionText: '¿Luces e intermitentes en buen estado?', questionType: 'YES_NO', isRequired: true, isCritical: false },
            { id: 'q6', questionText: 'Fotografía del kilometraje/horómetro actual', questionType: 'PHOTO', isRequired: true, isCritical: false },
          ],
        },
        {
          id: 'chk-epp',
          title: 'Elementos de Protección Personal (EPP)',
          description: 'Control de casco, chaleco reflectante, botas y guantes.',
          version: 1,
          isActive: true,
          questions: [
            { id: 'q7', questionText: '¿Cuenta con casco de seguridad con barbiquejo?', questionType: 'YES_NO', isRequired: true, isCritical: true },
            { id: 'q8', questionText: '¿Cuenta con zapatos de seguridad dielectricos y guantes?', questionType: 'YES_NO', isRequired: true, isCritical: true },
          ],
        },
        {
          id: 'chk-herramientas',
          title: 'Estado de Herramientas y Mangueras',
          description: 'Verificación del sistema de succión y lavado.',
          version: 1,
          isActive: true,
          questions: [
            { id: 'q9', questionText: '¿Mangueras de succión sin fisuras ni fugas?', questionType: 'YES_NO', isRequired: true, isCritical: true },
            { id: 'q10', questionText: '¿Válvulas de descarga ajustadas y operativas?', questionType: 'YES_NO', isRequired: true, isCritical: false },
          ],
        },
      ]);
    }
  };

  const fetchSubmissions = async () => {
    try {
      const response = await api.get('/api/v1/checklists/submissions');
      setSubmissions(response.data);
    } catch (_) {
      // Envíos de demostración enviados desde la app móvil
      setSubmissions([
        {
          id: 'sub-001',
          workerName: 'Juan Pérez',
          workerEmail: 'juan.perez@faena.cl',
          vehiclePlate: 'HX-8942',
          checklistTitle: 'Fatiga y Somnolencia',
          submittedAt: '2026-08-11 07:30:15',
          gpsLat: -23.6509,
          gpsLon: -70.3975,
          hasCriticalFailure: false,
          answers: [
            { questionText: '¿Durmió al menos 7 horas continuas antes del turno?', answerValue: 'SÍ', isCritical: true },
            { questionText: '¿Se encuentra tomando algún medicamento que produzca somnolencia?', answerValue: 'NO', isCritical: true },
            { questionText: 'Indique su nivel de energía actual (1 a 5)', answerValue: '5 - Óptimo', isCritical: false },
          ],
        },
        {
          id: 'sub-002',
          workerName: 'Carlos Gómez',
          workerEmail: 'carlos.gomez@faena.cl',
          vehiclePlate: 'CF-1234',
          checklistTitle: 'Estado del Camión / Equipo',
          submittedAt: '2026-08-11 08:05:42',
          gpsLat: -23.6482,
          gpsLon: -70.4012,
          hasCriticalFailure: true,
          answers: [
            { questionText: '¿Frenos de servicio y de mano funcionando correctamente?', answerValue: 'NO (Falla en prensa)', isCritical: true },
            { questionText: '¿Luces e intermitentes en buen estado?', answerValue: 'SÍ', isCritical: false },
            { questionText: 'Fotografía del kilometraje/horómetro actual', answerValue: 'Foto adjunta: odometer_8921.jpg', isCritical: false },
          ],
        },
      ]);
    }
  };

  useEffect(() => {
    fetchTemplates();
    fetchSubmissions();
  }, []);

  const handleCreateTemplate = async () => {
    if (!title.trim()) return;
    const newT: ChecklistTemplate = {
      id: `chk-${Date.now()}`,
      title,
      description,
      version: 1,
      isActive: true,
      questions: [],
    };
    setTemplates((prev) => [...prev, newT]);
    setOpenNewDialog(false);
    setTitle('');
    setDescription('');
  };

  const handleOpenDesigner = (template: ChecklistTemplate) => {
    setSelectedTemplate(template);
    setOpenDesigner(true);
  };

  const handleAddQuestion = () => {
    if (!selectedTemplate || !newQuestionText.trim()) return;
    const q: Question = {
      id: `q-${Date.now()}`,
      questionText: newQuestionText,
      questionType: newQuestionType,
      isRequired: newIsRequired,
      isCritical: newIsCritical,
    };
    const updatedTemplate = {
      ...selectedTemplate,
      questions: [...selectedTemplate.questions, q],
    };
    setSelectedTemplate(updatedTemplate);
    setTemplates((prev) => prev.map((t) => (t.id === updatedTemplate.id ? updatedTemplate : t)));
    setNewQuestionText('');
    setNewIsCritical(false);
  };

  const handleDeleteQuestion = (qId: string) => {
    if (!selectedTemplate) return;
    const updatedTemplate = {
      ...selectedTemplate,
      questions: selectedTemplate.questions.filter((q) => q.id !== qId),
    };
    setSelectedTemplate(updatedTemplate);
    setTemplates((prev) => prev.map((t) => (t.id === updatedTemplate.id ? updatedTemplate : t)));
  };

  const toggleTemplateStatus = (tId: string) => {
    setTemplates((prev) =>
      prev.map((t) => (t.id === tId ? { ...t, isActive: !t.isActive } : t))
    );
  };

  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', gap: 3 }}>
      {/* Header */}
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <Box>
          <Typography variant="h5" sx={{ fontWeight: 'bold' }}>
            Gestión de Checklists Operacionales
          </Typography>
          <Typography variant="body2" color="text.secondary">
            Parametrizador de formularios de seguridad y control de respuestas enviadas desde terreno.
          </Typography>
        </Box>
        {activeTab === 0 && (
          <Button
            variant="contained"
            startIcon={<AddIcon />}
            onClick={() => setOpenNewDialog(true)}
            sx={{ borderRadius: 2 }}
          >
            NUEVA PLANTILLA
          </Button>
        )}
      </Box>

      {/* Tabs */}
      <Paper elevation={0} sx={{ borderBottom: 1, borderColor: 'divider', borderRadius: 2 }}>
        <Tabs
          value={activeTab}
          onChange={(_, v) => setActiveTab(v)}
          textColor="primary"
          indicatorColor="primary"
        >
          <Tab
            icon={<TuneIcon />}
            iconPosition="start"
            label="PLANTILLAS Y DISEÑADOR DE PREGUNTAS"
            sx={{ fontWeight: 'bold' }}
          />
          <Tab
            icon={<AssignmentCheckIcon />}
            iconPosition="start"
            label={
              <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                <span>RESPUESTAS EN TERRENO</span>
                <Badge badgeContent={submissions.length} color="primary" />
              </Box>
            }
            sx={{ fontWeight: 'bold' }}
          />
        </Tabs>
      </Paper>

      {/* PESTAÑA 0: Plantillas y Diseñador */}
      {activeTab === 0 && (
        <Card elevation={1}>
          <TableContainer component={Paper} elevation={0}>
            <Table>
              <TableHead>
                <TableRow sx={{ backgroundColor: '#1E293B' }}>
                  <TableCell sx={{ color: 'white', fontWeight: 'bold' }}>Nombre Checklist</TableCell>
                  <TableCell sx={{ color: 'white', fontWeight: 'bold' }}>Descripción</TableCell>
                  <TableCell sx={{ color: 'white', fontWeight: 'bold' }}>Preguntas</TableCell>
                  <TableCell sx={{ color: 'white', fontWeight: 'bold' }}>Versión</TableCell>
                  <TableCell sx={{ color: 'white', fontWeight: 'bold' }}>Estado</TableCell>
                  <TableCell align="right" sx={{ color: 'white', fontWeight: 'bold' }}>Acciones</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {templates.map((t) => (
                  <TableRow key={t.id} hover>
                    <TableCell style={{ fontWeight: 'bold' }}>{t.title}</TableCell>
                    <TableCell>{t.description}</TableCell>
                    <TableCell>
                      <Chip label={`${t.questions?.length || 0} preguntas`} size="small" variant="outlined" />
                    </TableCell>
                    <TableCell>v{t.version}</TableCell>
                    <TableCell>
                      <Chip
                        label={t.isActive ? 'ACTIVO' : 'PAUSADO'}
                        color={t.isActive ? 'success' : 'default'}
                        size="small"
                        onClick={() => toggleTemplateStatus(t.id)}
                        sx={{ cursor: 'pointer' }}
                      />
                    </TableCell>
                    <TableCell align="right">
                      <Button
                        startIcon={<TuneIcon />}
                        size="small"
                        variant="outlined"
                        color="primary"
                        onClick={() => handleOpenDesigner(t)}
                      >
                        Diseñar Preguntas
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        </Card>
      )}

      {/* PESTAÑA 1: Respuestas de Terreno */}
      {activeTab === 1 && (
        <Card elevation={1}>
          <TableContainer component={Paper} elevation={0}>
            <Table>
              <TableHead>
                <TableRow sx={{ backgroundColor: '#1E293B' }}>
                  <TableCell sx={{ color: 'white', fontWeight: 'bold' }}>Fecha / Hora</TableCell>
                  <TableCell sx={{ color: 'white', fontWeight: 'bold' }}>Operador</TableCell>
                  <TableCell sx={{ color: 'white', fontWeight: 'bold' }}>Vehículo</TableCell>
                  <TableCell sx={{ color: 'white', fontWeight: 'bold' }}>Checklist</TableCell>
                  <TableCell sx={{ color: 'white', fontWeight: 'bold' }}>Resultado</TableCell>
                  <TableCell sx={{ color: 'white', fontWeight: 'bold' }}>Ubicación GPS</TableCell>
                  <TableCell align="right" sx={{ color: 'white', fontWeight: 'bold' }}>Acción</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {submissions.map((sub) => (
                  <TableRow key={sub.id} hover>
                    <TableCell sx={{ fontSize: '0.85rem' }}>{sub.submittedAt}</TableCell>
                    <TableCell style={{ fontWeight: 'bold' }}>
                      {sub.workerName}
                      <Typography variant="caption" display="block" color="text.secondary">
                        {sub.workerEmail}
                      </Typography>
                    </TableCell>
                    <TableCell>{sub.vehiclePlate}</TableCell>
                    <TableCell>{sub.checklistTitle}</TableCell>
                    <TableCell>
                      {sub.hasCriticalFailure ? (
                        <Chip
                          icon={<WarningAmberIcon />}
                          label="ALERTA CRÍTICA"
                          color="error"
                          size="small"
                          sx={{ fontWeight: 'bold' }}
                        />
                      ) : (
                        <Chip
                          icon={<CheckCircleIcon />}
                          label="CONFORME"
                          color="success"
                          size="small"
                          sx={{ fontWeight: 'bold' }}
                        />
                      )}
                    </TableCell>
                    <TableCell>
                      <Chip
                        icon={<LocationOnIcon />}
                        label={`${sub.gpsLat.toFixed(3)}, ${sub.gpsLon.toFixed(3)}`}
                        size="small"
                        variant="outlined"
                      />
                    </TableCell>
                    <TableCell align="right">
                      <Button
                        startIcon={<VisibilityIcon />}
                        size="small"
                        variant="contained"
                        color="info"
                        onClick={() => {
                          setSelectedSubmission(sub);
                          setOpenSubmissionDetail(true);
                        }}
                      >
                        Ver Detalle
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        </Card>
      )}

      {/* Modal Nueva Plantilla */}
      <Dialog open={openNewDialog} onClose={() => setOpenNewDialog(false)} fullWidth maxWidth="xs">
        <DialogTitle sx={{ fontWeight: 'bold' }}>Crear Plantilla de Checklist</DialogTitle>
        <DialogContent sx={{ display: 'flex', flexDirection: 'column', gap: 2.5, mt: 1 }}>
          <TextField
            label="Título del Checklist"
            fullWidth
            required
            placeholder="ej: Control de EPP Especializado"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
          />
          <TextField
            label="Descripción o Instrucciones de Uso"
            fullWidth
            multiline
            rows={3}
            value={description}
            onChange={(e) => setDescription(e.target.value)}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpenNewDialog(false)}>Cancelar</Button>
          <Button onClick={handleCreateTemplate} variant="contained">
            Crear Plantilla
          </Button>
        </DialogActions>
      </Dialog>

      {/* Modal Diseñador de Preguntas */}
      <Dialog open={openDesigner} onClose={() => setOpenDesigner(false)} fullWidth maxWidth="md">
        <DialogTitle sx={{ fontWeight: 'bold', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <span>Diseñador de Preguntas: {selectedTemplate?.title}</span>
          <Chip label={`v${selectedTemplate?.version}`} color="primary" size="small" />
        </DialogTitle>
        <DialogContent dividers sx={{ display: 'flex', flexDirection: 'column', gap: 3 }}>
          {/* Formulario Agregar Pregunta */}
          <Box sx={{ p: 2, bgcolor: 'action.hover', borderRadius: 2, display: 'flex', flexDirection: 'column', gap: 2 }}>
            <Typography variant="subtitle2" sx={{ fontWeight: 'bold', color: 'primary.main' }}>
              AGREGAR NUEVA PREGUNTA DINÁMICA
            </Typography>
            <TextField
              label="Texto de la Pregunta"
              fullWidth
              size="small"
              placeholder="ej: ¿Las luces estroboscópicas operan correctamente?"
              value={newQuestionText}
              onChange={(e) => setNewQuestionText(e.target.value)}
            />
            <Box sx={{ display: 'flex', gap: 2, flexWrap: 'wrap', alignItems: 'center' }}>
              <FormControl size="small" sx={{ minWidth: 200 }}>
                <InputLabel>Tipo de Respuesta</InputLabel>
                <Select
                  value={newQuestionType}
                  label="Tipo de Respuesta"
                  onChange={(e) => setNewQuestionType(e.target.value as any)}
                >
                  <MenuItem value="YES_NO">Sí / No</MenuItem>
                  <MenuItem value="TEXT">Texto Libre</MenuItem>
                  <MenuItem value="PHOTO">Fotografía Obligatoria</MenuItem>
                  <MenuItem value="MULTIPLE_CHOICE">Opción Múltiple</MenuItem>
                </Select>
              </FormControl>
              <FormControlLabel
                control={<Switch checked={newIsRequired} onChange={(e) => setNewIsRequired(e.target.checked)} />}
                label="Obligatoria"
              />
              <Tooltip title="Si se marca como crítico y el usuario responde NO o falla, se bloqueará automáticamente el ingreso del trabajador o vehículo en la app.">
                <FormControlLabel
                  control={
                    <Switch
                      checked={newIsCritical}
                      onChange={(e) => setNewIsCritical(e.target.checked)}
                      color="error"
                    />
                  }
                  label={<span style={{ color: newIsCritical ? '#ef4444' : 'inherit', fontWeight: newIsCritical ? 'bold' : 'normal' }}>Ítem Crítico de Bloqueo</span>}
                />
              </Tooltip>
              <Button variant="contained" color="success" size="small" onClick={handleAddQuestion} startIcon={<AddIcon />}>
                Agregar
              </Button>
            </Box>
          </Box>

          {/* Lista de Preguntas Existentes */}
          <Typography variant="subtitle2" sx={{ fontWeight: 'bold' }}>
            PREGUNTAS EN ESTA PLANTILLA ({selectedTemplate?.questions?.length || 0})
          </Typography>
          <List>
            {selectedTemplate?.questions?.map((q, index) => (
              <React.Fragment key={q.id}>
                <ListItem
                  secondaryAction={
                    <IconButton edge="end" color="error" onClick={() => handleDeleteQuestion(q.id)}>
                      <DeleteIcon />
                    </IconButton>
                  }
                >
                  <ListItemText
                    primary={
                      <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                        <Typography variant="body1" sx={{ fontWeight: 'bold' }}>
                          {index + 1}. {q.questionText}
                        </Typography>
                        {q.isCritical && (
                          <Chip label="CRÍTICO" color="error" size="small" sx={{ fontSize: '0.65rem', height: 20 }} />
                        )}
                        {q.isRequired && (
                          <Chip label="Requerido" size="small" variant="outlined" sx={{ fontSize: '0.65rem', height: 20 }} />
                        )}
                      </Box>
                    }
                    secondary={`Tipo de Respuesta: ${q.questionType}`}
                  />
                </ListItem>
                <Divider />
              </React.Fragment>
            ))}
          </List>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpenDesigner(false)} variant="contained">
            Guardar y Cerrar
          </Button>
        </DialogActions>
      </Dialog>

      {/* Modal Detalle de Envíos */}
      <Dialog open={openSubmissionDetail} onClose={() => setOpenSubmissionDetail(false)} fullWidth maxWidth="sm">
        <DialogTitle sx={{ fontWeight: 'bold' }}>
          Detalle del Checklist: {selectedSubmission?.checklistTitle}
        </DialogTitle>
        <DialogContent dividers sx={{ display: 'flex', flexDirection: 'column', gap: 2 }}>
          <Box sx={{ display: 'flex', justifyContent: 'space-between', bgcolor: 'action.hover', p: 1.5, borderRadius: 2 }}>
            <Box>
              <Typography variant="subtitle2" sx={{ fontWeight: 'bold' }}>{selectedSubmission?.workerName}</Typography>
              <Typography variant="caption" color="text.secondary">{selectedSubmission?.workerEmail}</Typography>
            </Box>
            <Box textAlign="right">
              <Typography variant="subtitle2" sx={{ fontWeight: 'bold' }}>Patente: {selectedSubmission?.vehiclePlate}</Typography>
              <Typography variant="caption" color="text.secondary">{selectedSubmission?.submittedAt}</Typography>
            </Box>
          </Box>

          <Typography variant="subtitle2" sx={{ fontWeight: 'bold', mt: 1 }}>
            Respuestas Registradas:
          </Typography>
          <List>
            {selectedSubmission?.answers.map((ans, idx) => (
              <ListItem key={idx} sx={{ flexDirection: 'column', alignItems: 'flex-start', bgcolor: ans.isCritical && ans.answerValue.startsWith('NO') ? '#fef2f2' : 'transparent', borderRadius: 1, mb: 1 }}>
                <Box sx={{ display: 'flex', justifyContent: 'space-between', width: '100%' }}>
                  <Typography variant="body2" sx={{ fontWeight: 'bold' }}>
                    {idx + 1}. {ans.questionText}
                  </Typography>
                  {ans.isCritical && <Chip label="ÍTEM CRÍTICO" color="error" size="small" sx={{ fontSize: '0.6rem', height: 18 }} />}
                </Box>
                <Typography variant="body1" sx={{ color: ans.isCritical && ans.answerValue.startsWith('NO') ? 'error.main' : 'success.main', fontWeight: 'bold', mt: 0.5 }}>
                  Respuesta: {ans.answerValue}
                </Typography>
              </ListItem>
            ))}
          </List>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpenSubmissionDetail(false)}>Cerrar</Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default Checklists;
