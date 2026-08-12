import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Tenant } from './tenant.entity';
import { User } from './user.entity';

@Entity('audit_logs')
export class AuditLog {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'uuid', name: 'tenant_id' })
  tenantId: string;

  @ManyToOne(() => Tenant, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'tenant_id' })
  tenant: Tenant;

  @Column({ type: 'uuid', name: 'user_id', nullable: true })
  userId: string;

  @ManyToOne(() => User, { onDelete: 'SET NULL', nullable: true })
  @JoinColumn({ name: 'user_id' })
  user: User;

  @Column({ type: 'varchar', length: 255 })
  action: string;

  @CreateDateColumn({ type: 'timestamp with time zone', name: 'timestamp' })
  timestamp: Date;

  @Column({ type: 'varchar', length: 255, name: 'device_info', nullable: true })
  deviceInfo: string;

  @Column({ type: 'double precision', name: 'gps_lat', nullable: true })
  gpsLat: number;

  @Column({ type: 'double precision', name: 'gps_lon', nullable: true })
  gpsLon: number;

  @Column({ type: 'jsonb', name: 'payload', default: '{}' })
  payload: any;
}
