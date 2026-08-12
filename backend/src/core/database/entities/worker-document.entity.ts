import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Tenant } from './tenant.entity';
import { WorkerProfile } from './worker-profile.entity';

export enum WorkerDocumentType {
  IDENTITY_CARD = 'IDENTITY_CARD',
  DRIVERS_LICENSE = 'DRIVERS_LICENSE',
  MEDICAL_EXAM = 'MEDICAL_EXAM',
  FAENA_PASS = 'FAENA_PASS',
}

@Entity('worker_documents')
export class WorkerDocument {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'uuid', name: 'tenant_id' })
  tenantId: string;

  @ManyToOne(() => Tenant, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'tenant_id' })
  tenant: Tenant;

  @Column({ type: 'uuid', name: 'worker_id' })
  workerId: string;

  @ManyToOne(() => WorkerProfile, (profile) => profile.documents, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'worker_id' })
  worker: WorkerProfile;

  @Column({ type: 'varchar', length: 100, name: 'document_type' })
  documentType: WorkerDocumentType;

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
