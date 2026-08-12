import { Controller, Post, Body, Get, UseGuards, Request, HttpCode, HttpStatus } from '@nestjs/common';
import { AuthService } from './auth.service';
import { JwtAuthGuard } from '../../core/guards/jwt-auth.guard';
import { TenantGuard } from '../../core/guards/tenant.guard';

@Controller('api/v1/auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  @HttpCode(HttpStatus.OK)
  async login(@Body() loginDto: { email: string; pass?: string; password?: string }) {
    const rawPassword = loginDto.pass || loginDto.password;
    const user = await this.authService.validateUser(loginDto.email, rawPassword || '');
    return this.authService.login(user);
  }

  @UseGuards(JwtAuthGuard, TenantGuard)
  @Get('profile')
  getProfile(@Request() req) {
    return req.user;
  }
}
