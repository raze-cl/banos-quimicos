import { Injectable, Inject, Scope } from '@nestjs/common';
import { REQUEST } from '@nestjs/core';
import { DataSource, EntityManager } from 'typeorm';

@Injectable({ scope: Scope.REQUEST })
export class TenantDatabaseService {
  private tenantId: string;

  constructor(
    @Inject(REQUEST) private readonly request: any,
    private readonly dataSource: DataSource,
  ) {
    // El tenantId se extrae del JWT decodificado adjunto en request.user
    this.tenantId = this.request?.user?.tenantId;
  }

  /**
   * Establece manualmente el tenantId (útil para tareas programadas o seeds)
   */
  setTenantId(tenantId: string) {
    this.tenantId = tenantId;
  }

  /**
   * Obtiene el tenantId activo en la solicitud
   */
  getTenantId(): string {
    return this.tenantId;
  }

  /**
   * Ejecuta una operación de base de datos garantizando que el tenant_id esté configurado
   * en la sesión local (PG SET LOCAL app.current_tenant_id) dentro de una transacción.
   */
  async execute<T>(
    operation: (manager: EntityManager) => Promise<T>,
    customTenantId?: string,
  ): Promise<T> {
    const activeTenantId = customTenantId || this.tenantId;
    if (!activeTenantId) {
      throw new Error('El contexto del inquilino (Tenant) no está establecido para esta operación.');
    }

    return this.dataSource.transaction(async (transactionalEntityManager) => {
      // Establece el tenant_id para RLS en la conexión actual (sólo dura esta transacción)
      await transactionalEntityManager.query(
        `SELECT set_config('app.current_tenant_id', $1, true)`,
        [activeTenantId],
      );
      return operation(transactionalEntityManager);
    });
  }
}
