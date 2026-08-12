import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '../../core/database/entities/user.entity';
import { WorkerProfile } from '../../core/database/entities/worker-profile.entity';
import { TenantDatabaseService } from '../../core/database/tenant-database.service';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private readonly usersRepository: Repository<User>,
    @InjectRepository(WorkerProfile)
    private readonly workersProfileRepository: Repository<WorkerProfile>,
    private readonly tenantDbService: TenantDatabaseService,
  ) {}

  /**
   * Busca un usuario por email (usado para autenticación global)
   * Nota: Esta consulta se realiza sin contexto de RLS ya que ocurre antes del login.
   */
  async findByEmail(email: string): Promise<User | null> {
    return this.usersRepository
      .createQueryBuilder('user')
      .leftJoinAndSelect('user.tenant', 'tenant')
      .addSelect('user.passwordHash')
      .where('user.email = :email AND user.isActive = :isActive', { email, isActive: true })
      .getOne();
  }

  /**
   * Crea un nuevo usuario y su perfil de trabajador asociado dentro de una transacción de tenant
   */
  async createWorker(
    tenantId: string,
    userData: Partial<User>,
    profileData: Partial<WorkerProfile>,
  ): Promise<User> {
    return this.tenantDbService.execute(async (manager) => {
      // 1. Crear el usuario
      const user = manager.create(User, {
        ...userData,
        tenantId,
      });
      const savedUser = await manager.save(User, user);

      // 2. Crear el perfil de trabajador
      const profile = manager.create(WorkerProfile, {
        ...profileData,
        tenantId,
        userId: savedUser.id,
      });
      await manager.save(WorkerProfile, profile);

      return savedUser;
    }, tenantId);
  }
}
