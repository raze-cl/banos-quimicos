import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersService } from './users.service';
import { User } from '../../core/database/entities/user.entity';
import { WorkerProfile } from '../../core/database/entities/worker-profile.entity';

@Module({
  imports: [TypeOrmModule.forFeature([User, WorkerProfile])],
  providers: [UsersService],
  exports: [UsersService],
})
export class UsersModule {}
