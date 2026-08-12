import { Controller, Get, Res } from '@nestjs/common';
import * as express from 'express';
import { ReportsService } from './reports.service';

@Controller('api/v1/reports')
export class ReportsController {
  constructor(private readonly reportsService: ReportsService) {}

  @Get('export/csv')
  async exportCSV(@Res() res: express.Response) {
    const csvData = await this.reportsService.generateRoutesComplianceCSV();
    
    res.setHeader('Content-Type', 'text/csv');
    res.setHeader('Content-Disposition', 'attachment; filename="reporte_cumplimiento_rutas.csv"');
    return res.send(csvData);
  }
}
