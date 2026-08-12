import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn, OneToMany } from 'typeorm';
import { Tenant } from './tenant.entity';
import { User } from './user.entity';
import { RoutePoint } from './route-point.entity';

export enum RouteStatus {
  PENDING = 'PENDING',
  IN_PROGRESS = 'IN_PROGRESS',
  COMPLETED = 'COMPLETED',
}

@Entity('routes')
export class Route {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'uuid', name: 'tenant_id' })
  tenantId: string;

  @ManyToOne(() => Tenant, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'tenant_id' })
  tenant: Tenant;

  @Column({ type: 'uuid', name: 'assigned_worker_id' })
  assignedWorkerId: string;

  @ManyToOne(() => User, { onDelete: 'RESTRICT' })
  @JoinColumn({ name: 'assigned_worker_id' })
  assignedWorker: User;

  @Column({ type: 'varchar', length: 255 })
  name: string;

  @Column({ type: 'varchar', length: 255, name: 'client_name' })
  clientName: string;

  @Column({ type: 'varchar', length: 255, name: 'faena_name' })
  faenaName: string;

  @Column({ type: 'varchar', length: 50, default: RouteStatus.PENDING })
  status: RouteStatus;

  @Column({ type: 'date', name: 'scheduled_date' })
  scheduledDate: string;

  @Column({ type: 'timestamp with time zone', name: 'started_at', nullable: true })
  startedAt: Date;

  @Column({ type: 'timestamp with time zone', name: 'completed_at', nullable: true })
  completedAt: Date;

  @CreateDateColumn({ type: 'timestamp with time zone', name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ type: 'timestamp with time zone', name: 'updated_at' })
  updatedAt: Date;

  @OneToMany(() => RoutePoint, (point) => point.route)
  points: RoutePoint[];
}
