import { Injectable } from '@nestjs/common';

@Injectable()
export class ReportsService {
  /**
   * Genera el contenido CSV del cumplimiento de rutas de la faena
   */
  async generateRoutesComplianceCSV(): Promise<string> {
    const headers = 'ID Ruta,Nombre Ruta,Cliente,Faena,Fecha Programada,Estado,Puntos Totales,Cumplimiento (%)\n';
    
    // Datos simulados de cumplimiento de rutas para exportación a Excel
    const rows = [
      ['route-001', 'Ruta Baños Químicos - Zona Norte', 'Minera Escondida', 'Escondida', '2026-08-06', 'COMPLETED', '3', '100%'],
      ['route-002', 'Ruta Mantención - Zona Sur', 'Anglo American', 'Los Bronces', '2026-08-06', 'COMPLETED', '2', '50%'],
      ['route-003', 'Servicio Técnico - Planta Central', 'Antofagasta Minerals', 'Centinela', '2026-08-07', 'IN_PROGRESS', '4', '75%'],
    ];

    const csvContent = rows.map((row) => row.map(val => `"${val}"`).join(',')).join('\n');
    return headers + csvContent;
  }
}
