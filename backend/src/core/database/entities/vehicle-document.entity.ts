import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Tenant } from './tenant.entity';
import { Vehicle } from './vehicle.entity';

export enum VehicleDocumentType {
  PERMIT = 'PERMIT',
  SOAP = 'SOAP',
  TECH_REVIEW = 'TECH_REVIEW',
  GAS_CERT = 'GAS_CERT',
}

@Entity('vehicle_documents')
export class VehicleDocument {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'uuid', name: 'tenant_id' })
  tenantId: string;

  @ManyToOne(() => Tenant, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'tenant_id' })
  tenant: Tenant;

  @Column({ type: 'uuid', name: 'vehicle_id' })
  vehicleId: string;

  @ManyToOne(() => Vehicle, (vehicle) => vehicle.documents, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'vehicle_id' })
  vehicle: Vehicle;

  @Column({ type: 'varchar', length: 100, name: 'document_type' })
  documentType: VehicleDocumentType;

  @Column({ type: 'date', name: 'emission_date' })
  emissionDate: string;

  @Column({ type: 'date', name: 'expiry_date' })
  expiryDate: string;

  @Column({ type: 'varchar', length: 512, name: 'file_url', nullable: true })
  fileUrl: string;

  @CreateDateColumn({ type: 'timestamp with time zone', name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ type: 'timestamp with time zone', name: 'updated_at' })
  updatedAt: Date;
}
