import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Tenant } from './tenant.entity';
import { ChecklistSubmission } from './checklist-submission.entity';
import { ChecklistQuestion } from './checklist-question.entity';

@Entity('checklist_answers')
export class ChecklistAnswer {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'uuid', name: 'tenant_id' })
  tenantId: string;

  @ManyToOne(() => Tenant, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'tenant_id' })
  tenant: Tenant;

  @Column({ type: 'uuid', name: 'submission_id' })
  submissionId: string;

  @ManyToOne(() => ChecklistSubmission, (submission) => submission.answers, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'submission_id' })
  submission: ChecklistSubmission;

  @Column({ type: 'uuid', name: 'question_id' })
  questionId: string;

  @ManyToOne(() => ChecklistQuestion, { onDelete: 'RESTRICT' })
  @JoinColumn({ name: 'question_id' })
  question: ChecklistQuestion;

  @Column({ type: 'text', name: 'answer_value' })
  answerValue: string;

  @Column({ type: 'varchar', length: 512, name: 'photo_url', nullable: true })
  photoUrl: string;

  @Column({ type: 'varchar', length: 512, name: 'signature_url', nullable: true })
  signatureUrl: string;

  @Column({ type: 'boolean', name: 'is_failed_critical', default: false })
  isFailedCritical: boolean;

  @CreateDateColumn({ type: 'timestamp with time zone', name: 'created_at' })
  createdAt: Date;
}
