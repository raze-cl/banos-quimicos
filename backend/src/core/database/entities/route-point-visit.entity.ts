import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Tenant } from './tenant.entity';
import { RoutePoint } from './route-point.entity';

@Entity('route_point_visits')
export class RoutePointVisit {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'uuid', name: 'tenant_id' })
  tenantId: string;

  @ManyToOne(() => Tenant, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'tenant_id' })
  tenant: Tenant;

  @Column({ type: 'uuid', name: 'point_id' })
  pointId: string;

  @ManyToOne(() => RoutePoint, (point) => point.visits, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'point_id' })
  point: RoutePoint;

  @Column({ type: 'timestamp with time zone', name: 'visited_at' })
  visitedAt: Date;

  @Column({ type: 'double precision', name: 'gps_lat' })
  gpsLat: number;

  @Column({ type: 'double precision', name: 'gps_lon' })
  gpsLon: number;

  @Column({ type: 'double precision', name: 'gps_accuracy' })
  gpsAccuracy: number;

  @Column({ type: 'text', array: true, name: 'photos_before', default: '{}' })
  photosBefore: string[];

  @Column({ type: 'text', array: true, name: 'photos_after', default: '{}' })
  photosAfter: string[];

  @Column({ type: 'jsonb', name: 'form_data', default: '{}' })
  formData: any;

  @CreateDateColumn({ type: 'timestamp with time zone', name: 'created_at' })
  createdAt: Date;
}
