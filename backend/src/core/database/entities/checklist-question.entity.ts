import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, ManyToOne, JoinColumn, OneToMany } from 'typeorm';
import { Tenant } from './tenant.entity';
import { Checklist } from './checklist.entity';
import { ChecklistQuestionOption } from './checklist-question-option.entity';

export enum QuestionType {
  YES_NO = 'YES_NO',
  MULTIPLE_CHOICE = 'MULTIPLE_CHOICE',
  TEXT = 'TEXT',
  NUMBER = 'NUMBER',
  PHOTO = 'PHOTO',
  SIGNATURE = 'SIGNATURE',
}

@Entity('checklist_questions')
export class ChecklistQuestion {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'uuid', name: 'tenant_id' })
  tenantId: string;

  @ManyToOne(() => Tenant, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'tenant_id' })
  tenant: Tenant;

  @Column({ type: 'uuid', name: 'checklist_id' })
  checklistId: string;

  @ManyToOne(() => Checklist, (checklist) => checklist.questions, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'checklist_id' })
  checklist: Checklist;

  @Column({ type: 'text', name: 'question_text' })
  questionText: string;

  @Column({ type: 'varchar', length: 50, name: 'question_type' })
  questionType: QuestionType;

  @Column({ type: 'boolean', name: 'is_required', default: true })
  isRequired: boolean;

  @Column({ type: 'boolean', name: 'is_critical', default: false })
  isCritical: boolean;

  @Column({ type: 'int', name: 'sort_order', default: 0 })
  sortOrder: number;

  @CreateDateColumn({ type: 'timestamp with time zone', name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ type: 'timestamp with time zone', name: 'updated_at' })
  updatedAt: Date;

  @OneToMany(() => ChecklistQuestionOption, (option) => option.question)
  options: ChecklistQuestionOption[];
}
