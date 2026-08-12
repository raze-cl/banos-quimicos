import { Module, Global } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TenantDatabaseService } from './tenant-database.service';
import { Tenant } from './entities/tenant.entity';
import { User } from './entities/user.entity';
import { WorkerProfile } from './entities/worker-profile.entity';
import { WorkerDocument } from './entities/worker-document.entity';
import { Vehicle } from './entities/vehicle.entity';
import { VehicleDocument } from './entities/vehicle-document.entity';
import { Checklist } from './entities/checklist.entity';
import { ChecklistQuestion } from './entities/checklist-question.entity';
import { ChecklistQuestionOption } from './entities/checklist-question-option.entity';
import { Route } from './entities/route.entity';
import { RoutePoint } from './entities/route-point.entity';
import { RoutePointVisit } from './entities/route-point-visit.entity';
import { ChecklistSubmission } from './entities/checklist-submission.entity';
import { ChecklistAnswer } from './entities/checklist-answer.entity';
import { AuditLog } from './entities/audit-log.entity';

@Global()
@Module({
  imports: [
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        type: 'postgres',
        url: configService.get<string>('DATABASE_URL'),
        ssl: configService.get<string>('DB_SSL') === 'true' ? { rejectUnauthorized: false } : false,
        entities: [
          Tenant,
          User,
          WorkerProfile,
          WorkerDocument,
          Vehicle,
          VehicleDocument,
          Checklist,
          ChecklistQuestion,
          ChecklistQuestionOption,
          Route,
          RoutePoint,
          RoutePointVisit,
          ChecklistSubmission,
          ChecklistAnswer,
          AuditLog,
        ],
        synchronize: false, // Las migraciones las maneja Supabase
        logging: configService.get<string>('NODE_ENV') === 'development',
      }),
    }),
  ],
  providers: [TenantDatabaseService],
  exports: [TenantDatabaseService, TypeOrmModule],
})
export class DatabaseModule {}
