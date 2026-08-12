import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn, OneToMany } from 'typeorm';
import { Tenant } from './tenant.entity';
import { Route } from './route.entity';
import { RoutePointVisit } from './route-point-visit.entity';

export enum RoutePointStatus {
  PENDING = 'PENDING',
  COMPLETED = 'COMPLETED',
  OMITTED = 'OMITTED',
}

@Entity('route_points')
export class RoutePoint {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'uuid', name: 'tenant_id' })
  tenantId: string;

  @ManyToOne(() => Tenant, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'tenant_id' })
  tenant: Tenant;

  @Column({ type: 'uuid', name: 'route_id' })
  routeId: string;

  @ManyToOne(() => Route, (route) => route.points, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'route_id' })
  route: Route;

  @Column({ type: 'varchar', length: 255 })
  name: string;

  @Column({ type: 'varchar', length: 255, name: 'qr_code_token' })
  qrCodeToken: string;

  @Column({ type: 'int', name: 'sequence_order' })
  sequenceOrder: number;

  @Column({ type: 'varchar', length: 50, default: RoutePointStatus.PENDING })
  status: RoutePointStatus;

  @CreateDateColumn({ type: 'timestamp with time zone', name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ type: 'timestamp with time zone', name: 'updated_at' })
  updatedAt: Date;

  @OneToMany(() => RoutePointVisit, (visit) => visit.point)
  visits: RoutePointVisit[];
}
