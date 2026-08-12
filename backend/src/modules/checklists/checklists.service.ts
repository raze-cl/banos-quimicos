import { Injectable } from '@nestjs/common';

@Injectable()
export class ChecklistsService {
  private templates = [
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
  ];

  private submissions = [
    {
      id: 'sub-001',
      workerName: 'Juan Pérez',
      workerEmail: 'juan.perez@faena.cl',
      vehiclePlate: 'HX-8942',
      checklistTitle: 'Fatiga y Somnolencia',
      submittedAt: new Date().toISOString().replace('T', ' ').substring(0, 19),
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
      submittedAt: new Date().toISOString().replace('T', ' ').substring(0, 19),
      gpsLat: -23.6482,
      gpsLon: -70.4012,
      hasCriticalFailure: true,
      answers: [
        { questionText: '¿Frenos de servicio y de mano funcionando correctamente?', answerValue: 'NO (Falla en prensa)', isCritical: true },
        { questionText: '¿Luces e intermitentes en buen estado?', answerValue: 'SÍ', isCritical: false },
        { questionText: 'Fotografía del kilometraje/horómetro actual', answerValue: 'Foto adjunta: odometer_8921.jpg', isCritical: false },
      ],
    },
  ];

  getTemplates() {
    return this.templates;
  }

  createTemplate(title: string, description: string) {
    const newTemplate = {
      id: `chk-${Date.now()}`,
      title,
      description,
      version: 1,
      isActive: true,
      questions: [],
    };
    this.templates.push(newTemplate);
    return newTemplate;
  }

  addQuestion(
    templateId: string,
    questionText: string,
    questionType: string,
    isRequired: boolean,
    isCritical: boolean,
  ) {
    const template = this.templates.find((t) => t.id === templateId);
    if (!template) {
      throw new Error('Plantilla no encontrada');
    }
    const newQuestion = {
      id: `q-${Date.now()}`,
      questionText,
      questionType,
      isRequired,
      isCritical,
    };
    template.questions.push(newQuestion);
    return newQuestion;
  }

  getSubmissions() {
    return this.submissions;
  }

  submitChecklist(payload: any) {
    const newSub = {
      id: `sub-${Date.now()}`,
      workerName: payload.workerName || 'Operador Faena',
      workerEmail: payload.workerEmail || 'operador@faena.cl',
      vehiclePlate: payload.vehiclePlate || 'CAMION-001',
      checklistTitle: payload.checklistTitle || 'Checklist de Seguridad',
      submittedAt: new Date().toISOString().replace('T', ' ').substring(0, 19),
      gpsLat: payload.gpsLat || -23.65,
      gpsLon: payload.gpsLon || -70.4,
      hasCriticalFailure: payload.hasCriticalFailure || false,
      answers: payload.answers || [],
    };
    this.submissions.unshift(newSub);
    return { success: true, submissionId: newSub.id };
  }
}
