import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, ManyToOne, JoinColumn, OneToMany } from 'typeorm';
import { Tenant } from './tenant.entity';
import { User } from './user.entity';
import { Vehicle } from './vehicle.entity';
import { Route } from './route.entity';
import { Checklist } from './checklist.entity';
import { ChecklistAnswer } from './checklist-answer.entity';

@Entity('checklists_submissions')
export class ChecklistSubmission {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'uuid', name: 'tenant_id' })
  tenantId: string;

  @ManyToOne(() => Tenant, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'tenant_id' })
  tenant: Tenant;

  @Column({ type: 'uuid', name: 'user_id' })
  userId: string;

  @ManyToOne(() => User, { onDelete: 'RESTRICT' })
  @JoinColumn({ name: 'user_id' })
  user: User;

  @Column({ type: 'uuid', name: 'vehicle_id', nullable: true })
  vehicleId: string;

  @ManyToOne(() => Vehicle, { onDelete: 'SET NULL', nullable: true })
  @JoinColumn({ name: 'vehicle_id' })
  vehicle: Vehicle;

  @Column({ type: 'uuid', name: 'route_id', nullable: true })
  routeId: string;

  @ManyToOne(() => Route, { onDelete: 'SET NULL', nullable: true })
  @JoinColumn({ name: 'route_id' })
  route: Route;

  @Column({ type: 'uuid', name: 'checklist_id' })
  checklistId: string;

  @ManyToOne(() => Checklist, { onDelete: 'RESTRICT' })
  @JoinColumn({ name: 'checklist_id' })
  checklist: Checklist;

  @Column({ type: 'timestamp with time zone', name: 'submitted_at' })
  submittedAt: Date;

  @Column({ type: 'double precision', name: 'gps_lat' })
  gpsLat: number;

  @Column({ type: 'double precision', name: 'gps_lon' })
  gpsLon: number;

  @Column({ type: 'double precision', name: 'gps_accuracy' })
  gpsAccuracy: number;

  @CreateDateColumn({ type: 'timestamp with time zone', name: 'created_at' })
  createdAt: Date;

  @OneToMany(() => ChecklistAnswer, (answer) => answer.submission)
  answers: ChecklistAnswer[];
}
