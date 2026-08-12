import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../database/local_database.dart';
import '../network/api_client.dart';
import '../network/connectivity_service.dart';
import '../../features/sync/data/sync_queue_repository.dart';
import '../../features/sync/domain/sync_manager.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/verification/data/repositories/verification_repository.dart';
import '../../features/verification/presentation/cubit/verification_cubit.dart';
import '../../features/checklists/data/repositories/checklists_repository.dart';
import '../../features/checklists/presentation/cubit/checklist_cubit.dart';
import '../../features/routes/data/repositories/routes_repository.dart';
import '../../features/routes/presentation/cubit/routes_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator({required String baseUrl}) async {
  // 1. Almacenamiento seguro
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // 2. Base de datos local SQLite
  sl.registerLazySingleton<LocalDatabase>(
    () => LocalDatabase(),
  );

  // 3. Conectividad
  sl.registerLazySingleton<ConnectivityService>(
    () => ConnectivityService(),
  );

  // 4. API Client (Dio wrapper)
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(
      baseUrl: baseUrl,
      secureStorage: sl<FlutterSecureStorage>(),
    ),
  );

  // 5. Repositorios de Sincronización
  sl.registerLazySingleton<SyncQueueRepository>(
    () => SyncQueueRepository(sl<LocalDatabase>()),
  );

  // 6. Sync Manager
  sl.registerLazySingleton<SyncManager>(
    () => SyncManager(
      queueRepository: sl<SyncQueueRepository>(),
      apiClient: sl<ApiClient>(),
      connectivityService: sl<ConnectivityService>(),
      database: sl<LocalDatabase>(),
    ),
  );

  // 7. Repositorios de Características
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      apiClient: sl<ApiClient>(),
      secureStorage: sl<FlutterSecureStorage>(),
      connectivityService: sl<ConnectivityService>(),
    ),
  );

  sl.registerLazySingleton<VerificationRepository>(
    () => VerificationRepository(
      apiClient: sl<ApiClient>(),
      database: sl<LocalDatabase>(),
      connectivityService: sl<ConnectivityService>(),
      syncQueueRepository: sl<SyncQueueRepository>(),
    ),
  );

  sl.registerLazySingleton<ChecklistsRepository>(
    () => ChecklistsRepository(
      apiClient: sl<ApiClient>(),
      database: sl<LocalDatabase>(),
      connectivityService: sl<ConnectivityService>(),
      syncQueueRepository: sl<SyncQueueRepository>(),
    ),
  );

  sl.registerLazySingleton<RoutesRepository>(
    () => RoutesRepository(
      apiClient: sl<ApiClient>(),
      database: sl<LocalDatabase>(),
      connectivityService: sl<ConnectivityService>(),
      syncQueueRepository: sl<SyncQueueRepository>(),
    ),
  );

  // 8. Cubits / State Management (factory)
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(sl<AuthRepository>()),
  );

  sl.registerFactory<VerificationCubit>(
    () => VerificationCubit(sl<VerificationRepository>()),
  );

  sl.registerFactory<ChecklistCubit>(
    () => ChecklistCubit(sl<ChecklistsRepository>()),
  );

  sl.registerFactory<RoutesCubit>(
    () => RoutesCubit(sl<RoutesRepository>()),
  );
}
