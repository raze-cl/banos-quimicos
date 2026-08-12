import { Injectable, ConflictException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Tenant } from '../../core/database/entities/tenant.entity';
import { UsersService } from '../users/users.service';
import { UserRole } from '../../core/database/entities/user.entity';
import { AuthService } from '../auth/auth.service';

@Injectable()
export class TenantsService {
  constructor(
    @InjectRepository(Tenant)
    private readonly tenantsRepository: Repository<Tenant>,
    private readonly usersService: UsersService,
    private readonly authService: AuthService,
  ) {}

  /**
   * Crea una nueva empresa / inquilino (Tenant)
   */
  async create(name: string, rut: string): Promise<Tenant> {
    const existing = await this.tenantsRepository.findOne({ where: { rut } });
    if (existing) {
      throw new ConflictException('Ya existe una empresa registrada con ese RUT.');
    }
    const tenant = this.tenantsRepository.create({ name, rut });
    return this.tenantsRepository.save(tenant);
  }

  /**
   * Obtiene todos los inquilinos activos
   */
  async findAll(): Promise<Tenant[]> {
    return this.tenantsRepository.find({ where: { isActive: true } });
  }

  /**
   * Seed para pruebas operacionales iniciales
   * Crea un Tenant demo y dos usuarios (Admin y Worker) si no existen.
   */
  async seedDemoData(): Promise<any> {
    let tenant = await this.tenantsRepository.findOne({ where: { rut: '12.345.678-9' } });
    if (!tenant) {
      tenant = await this.create('Minera Demo S.A.', '12.345.678-9');
    }

    const workerEmail = 'trabajador@minera.com';
    let workerUser = await this.usersService.findByEmail(workerEmail);
    if (!workerUser) {
      const passwordHash = await this.authService.hashPassword('password123');
      workerUser = await this.usersService.createWorker(
        tenant.id,
        {
          email: workerEmail,
          passwordHash,
          role: UserRole.WORKER,
        },
        {
          rut: '19.876.543-2',
          firstName: 'Juan',
          lastName: 'Pérez',
          phone: '+56912345678',
          licenseNumber: 'B-19876543',
          licenseClass: 'Clase B profesional',
        },
      );
    }

    const adminEmail = 'admin@minera.com';
    let adminUser = await this.usersService.findByEmail(adminEmail);
    if (!adminUser) {
      const passwordHash = await this.authService.hashPassword('admin123');
      adminUser = await this.usersService.createWorker(
        tenant.id,
        {
          email: adminEmail,
          passwordHash,
          role: UserRole.ADMIN,
        },
        {
          rut: '15.654.321-0',
          firstName: 'Carlos',
          lastName: 'Mendoza',
          phone: '+56987654321',
        },
      );
    }

    return {
      message: 'Base de datos seeded con éxito para demo.',
      tenant: { id: tenant.id, name: tenant.name },
      worker: { email: workerEmail, pass: 'password123' },
      admin: { email: adminEmail, pass: 'admin123' },
    };
  }
}
