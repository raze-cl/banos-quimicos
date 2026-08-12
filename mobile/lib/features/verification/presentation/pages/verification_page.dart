import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/auth/data/models/user_model.dart';
import 'package:mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mobile/features/auth/presentation/pages/login_page.dart';
import 'package:mobile/features/verification/presentation/cubit/verification_cubit.dart';
import 'package:mobile/features/verification/presentation/cubit/verification_state.dart';
import 'package:mobile/features/verification/data/models/document_model.dart';
import 'package:mobile/features/verification/data/models/vehicle_model.dart';
import 'package:mobile/features/routes/presentation/pages/routes_list_page.dart';
import 'package:mobile/core/di/service_locator.dart';

class VerificationPage extends StatefulWidget {
  final UserModel user;

  const VerificationPage({super.key, required this.user});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late final VerificationCubit _verificationCubit;
  final _qrController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _verificationCubit = sl<VerificationCubit>();
    _verificationCubit.checkWorkerDocuments(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _verificationCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('VALIDACIÓN DIARIA'),
          backgroundColor: const Color(0xFF1E293B),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
              tooltip: 'Cerrar Sesión',
              onPressed: () => _showLogoutDialog(context),
            ),
          ],
        ),
        body: BlocConsumer<VerificationCubit, VerificationState>(
          listener: (context, state) {
            if (state is VerificationSuccess) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>
                      RoutesListPage(user: widget.user),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is VerificationLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is VerificationBlocked) {
              return _buildBlockedScreen(state.reason);
            }

            if (state is VerificationError) {
              return _buildErrorScreen(state.message);
            }

            if (state is WorkerDocsChecked) {
              return _buildWorkerDocsCheckedScreen(state.docs);
            }

            if (state is VehicleQRScanned) {
              return _buildVehicleQRScannedScreen(state.vehicle, state.docs);
            }

            return const Center(
              child: Text('Estado de verificación desconocido.'),
            );
          },
        ),
      ),
    );
  }

  // Pantalla de Bloqueo Total (Cuando existe un documento vencido o falla crítica)
  Widget _buildBlockedScreen(String reason) {
    return Container(
      color: const Color(0xFF450A0A), // Rojo Sangre Oscuro
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.block_flipped, size: 80, color: Colors.redAccent),
          const SizedBox(height: 24),
          const Text(
            'INGRESO BLOQUEADO',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            reason,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white70,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.mark_email_unread_rounded, color: Colors.amber),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Se ha notificado automáticamente al supervisor general por correo electrónico.',
                    style: TextStyle(fontSize: 12, color: Colors.amber),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              _verificationCubit.checkWorkerDocuments(widget.user.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'REINTENTAR VALIDACIÓN',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Pantalla de Error
  Widget _buildErrorScreen(String message) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 60,
            color: Colors.amber,
          ),
          const SizedBox(height: 16),
          const Text(
            'Error de Carga',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () =>
                _verificationCubit.checkWorkerDocuments(widget.user.id),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  // Pantalla 1: Documentación del Trabajador Aprobada
  Widget _buildWorkerDocsCheckedScreen(List<DocumentModel> docs) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.green, size: 28),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'DOCUMENTOS TRABAJADOR HABILITADOS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDocsList(docs),
          const SizedBox(height: 40),
          const Text(
            'ESCANEO DE VEHÍCULO REQUERIDO',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () => _showQRScanDialog(),
            icon: const Icon(Icons.qr_code_scanner_rounded),
            label: const Text('ESCANEAR QR VEHÍCULO'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Pantalla 2: Vehículo Escaneado y Documentos del Vehículo mostrados
  Widget _buildVehicleQRScannedScreen(
    VehicleModel vehicle,
    List<DocumentModel> docs,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'VEHÍCULO IDENTIFICADO',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${vehicle.brand} ${vehicle.model} (${vehicle.year})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.pin_rounded,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Patente: ${vehicle.plateNumber}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.speed_rounded,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${vehicle.lastOdometer} KM',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DOCUMENTOS DEL VEHÍCULO',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          _buildDocsList(docs),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => _verificationCubit.approveVerification(vehicle),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'CONFIRMAR VEHÍCULO E INICIAR RUTAS',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Lista genérica de Documentos con Semáforo
  Widget _buildDocsList(List<DocumentModel> docs) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: docs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final doc = docs[index];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              _buildSemaphoreIcon(doc.status),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc.documentName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Vence: ${doc.expiryDate}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text(
                '${doc.daysToExpiry} días',
                style: TextStyle(
                  color: _getSemaphoreColor(doc.status),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSemaphoreIcon(DocumentStatus status) {
    Color color = Colors.grey;
    if (status == DocumentStatus.green) color = Colors.green;
    if (status == DocumentStatus.yellow) color = Colors.amber;
    if (status == DocumentStatus.red) color = Colors.red;

    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }

  Color _getSemaphoreColor(DocumentStatus status) {
    if (status == DocumentStatus.green) return Colors.green;
    if (status == DocumentStatus.yellow) return Colors.amber;
    return Colors.red;
  }

  // Dialogo de simulación de QR de Vehículo
  void _showQRScanDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Escaneo QR de Vehículo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Para propósitos de demostración, ingresa un token QR de camión (ej. CAMION-001):',
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _qrController,
                decoration: const InputDecoration(
                  labelText: 'Token QR del Camión',
                  hintText: 'CAMION-001',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final token = _qrController.text.trim();
                Navigator.of(context).pop();
                if (token.isNotEmpty) {
                  _verificationCubit.scanVehicleQR(token, widget.user.id);
                }
              },
              child: const Text('Escanear'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text(
          '¿Estás seguro de que deseas cerrar sesión? Deberás volver a ingresar tus credenciales y realizar el proceso de verificación.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<AuthCubit>().logout();
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _qrController.dispose();
    super.dispose();
  }
}
