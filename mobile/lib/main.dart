import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_locator.dart';
import 'core/network/connectivity_service.dart';
import 'features/sync/domain/sync_manager.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/cubit/auth_state.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/checklists/presentation/pages/checklists_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa el localizador de servicios apuntando a la dirección local estándar del emulador de Android (10.0.2.2)
  await initServiceLocator(baseUrl: 'http://10.0.2.2:3000');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => sl<AuthCubit>()..checkActiveSession(),
      child: MaterialApp(
        title: 'Gestión Operacional Faenas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1E3A8A), // Azul Minero Profundo
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: const Color(0xFF0F172A), // Slate 900
          cardTheme: const CardThemeData(
            color: Color(0xFF1E293B), // Slate 800
            elevation: 4,
          ),
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial || state is AuthLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (state is Authenticated) {
              return ChecklistsPage(user: state.user);
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}

class OperationalDashboard extends StatefulWidget {
  const OperationalDashboard({super.key});

  @override
  State<OperationalDashboard> createState() => _OperationalDashboardState();
}

class _OperationalDashboardState extends State<OperationalDashboard> {
  final ConnectivityService _connectivity = sl<ConnectivityService>();
  final SyncManager _syncManager = sl<SyncManager>();

  bool _isConnected = false;
  SyncStatus _syncStatus = SyncStatus.idle;
  int _pendingEvents = 0;

  @override
  void initState() {
    super.initState();
    _initListeners();
  }

  void _initListeners() async {
    // 1. Obtener estado de red inicial y escuchar cambios
    _isConnected = await _connectivity.isConnected;
    _connectivity.onConnectivityChanged.listen((connected) {
      if (mounted) {
        setState(() => _isConnected = connected);
      }
    });

    // 2. Escuchar cambios de estado del Sync Manager
    _syncStatus = _syncManager.currentStatus;
    _syncManager.statusStream.listen((status) {
      if (mounted) {
        setState(() => _syncStatus = status);
      }
    });

    // 3. Escuchar cola de sincronización pendiente
    _syncManager.pendingCountStream.listen((count) {
      if (mounted) {
        setState(() => _pendingEvents = count);
      }
    });

    // Disparar sincronización inicial de prueba si está online
    _syncManager.updatePendingCount();
    if (_isConnected) {
      _syncManager.triggerSync();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GESTIÓN OPERACIONAL',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E293B),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _syncManager.updatePendingCount();
              _syncManager.triggerSync();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tarjeta de estado de conexión y sincronización
            _buildStatusCard(),
            const SizedBox(height: 20),

            // Módulos operacionales
            const Text(
              'FLUJOS OPERACIONALES (FASE 3 & 4)',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 10),
            _buildFlowButton(
              title: 'Ingreso Diario y Documentación',
              subtitle: 'Semáforo de pase y exámenes médicos',
              icon: Icons.assignment_ind_rounded,
              color: Colors.tealAccent,
            ),
            const SizedBox(height: 12),
            _buildFlowButton(
              title: 'Escaneo de Vehículo (QR)',
              subtitle: 'Validación de patentes y seguros',
              icon: Icons.qr_code_scanner_rounded,
              color: Colors.amberAccent,
            ),
            const SizedBox(height: 12),
            _buildFlowButton(
              title: 'Checklists de Seguridad',
              subtitle: 'Fatiga, EPP y estado de equipos',
              icon: Icons.playlist_add_check_circle_rounded,
              color: Colors.orangeAccent,
            ),
            const SizedBox(height: 12),
            _buildFlowButton(
              title: 'Rutas Asignadas y GPS',
              subtitle: 'Control georreferenciado offline',
              icon: Icons.map_rounded,
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Conectividad de Red',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                _buildChip(
                  text: _isConnected ? 'ONLINE' : 'OFFLINE',
                  color: _isConnected ? Colors.green : Colors.red,
                  icon: _isConnected ? Icons.wifi : Icons.wifi_off,
                ),
              ],
            ),
            const Divider(height: 30, color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sincronizador FIFO',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                _buildSyncStatusChip(),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.cloud_upload_rounded, color: Colors.blue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '$_pendingEvents registros pendientes en cola local',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlowButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Flujo "$title" se activará en las siguientes fases de desarrollo.',
            ),
            backgroundColor: Colors.indigo,
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip({
    required String text,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncStatusChip() {
    switch (_syncStatus) {
      case SyncStatus.idle:
        return _buildChip(
          text: 'EN ESPERA',
          color: Colors.grey,
          icon: Icons.sync,
        );
      case SyncStatus.syncing:
        return _buildChip(
          text: 'SINCRONIZANDO',
          color: Colors.blue,
          icon: Icons.refresh,
        );
      case SyncStatus.error:
        return _buildChip(
          text: 'REINTENTANDO',
          color: Colors.amber,
          icon: Icons.warning_amber,
        );
    }
  }
}
