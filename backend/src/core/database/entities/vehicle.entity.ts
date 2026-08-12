import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn, OneToMany, Unique } from 'typeorm';
import { Tenant } from './tenant.entity';
import { VehicleDocument } from './vehicle-document.entity';

@Entity('vehicles')
@Unique('unique_plate_per_tenant', ['tenantId', 'plateNumber'])
export class Vehicle {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'uuid', name: 'tenant_id' })
  tenantId: string;

  @ManyToOne(() => Tenant, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'tenant_id' })
  tenant: Tenant;

  @Column({ type: 'varchar', length: 50, name: 'plate_number' })
  plateNumber: string;

  @Column({ type: 'varchar', length: 100 })
  brand: string;

  @Column({ type: 'varchar', length: 100 })
  model: string;

  @Column({ type: 'int' })
  year: number;

  @Column({ type: 'int', name: 'last_odometer', default: 0 })
  lastOdometer: number;

  @Column({ type: 'varchar', length: 255, name: 'qr_code_token', unique: true })
  qrCodeToken: string;

  @Column({ type: 'boolean', name: 'is_active', default: true })
  isActive: boolean;

  @CreateDateColumn({ type: 'timestamp with time zone', name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ type: 'timestamp with time zone', name: 'updated_at' })
  updatedAt: Date;

  @OneToMany(() => VehicleDocument, (doc) => doc.vehicle)
  documents: VehicleDocument[];
}
