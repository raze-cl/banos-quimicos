import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { ChecklistsService } from './checklists.service';

@Controller('api/v1/checklists')
export class ChecklistsController {
  constructor(private readonly checklistsService: ChecklistsService) {}

  @Get('templates')
  getTemplates() {
    return this.checklistsService.getTemplates();
  }

  @Post('templates')
  createTemplate(@Body() body: { title: string; description: string }) {
    return this.checklistsService.createTemplate(body.title, body.description);
  }

  @Post('templates/:id/questions')
  addQuestion(
    @Param('id') templateId: string,
    @Body() body: { questionText: string; questionType: string; isRequired?: boolean; isCritical?: boolean },
  ) {
    return this.checklistsService.addQuestion(
      templateId,
      body.questionText,
      body.questionType,
      body.isRequired ?? true,
      body.isCritical ?? false,
    );
  }

  @Get('submissions')
  getSubmissions() {
    return this.checklistsService.getSubmissions();
  }

  @Post('submissions')
  submitChecklist(@Body() body: any) {
    return this.checklistsService.submitChecklist(body);
  }
}
