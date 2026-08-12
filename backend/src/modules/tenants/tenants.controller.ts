import { Controller, Get, Post } from '@nestjs/common';
import { TenantsService } from './tenants.service';

@Controller('api/v1/tenants')
export class TenantsController {
  constructor(private readonly tenantsService: TenantsService) {}

  @Get()
  async findAll() {
    return this.tenantsService.findAll();
  }

  @Post('seed')
  async seed() {
    return this.tenantsService.seedDemoData();
  }
}
