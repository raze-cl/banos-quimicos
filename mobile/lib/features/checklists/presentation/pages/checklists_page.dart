import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:mobile/features/auth/data/models/user_model.dart';
import 'package:mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mobile/features/auth/presentation/pages/login_page.dart';
import 'package:mobile/features/verification/data/models/vehicle_model.dart';
import 'package:mobile/features/verification/presentation/pages/verification_page.dart';
import 'package:mobile/features/checklists/presentation/cubit/checklist_cubit.dart';
import 'package:mobile/features/checklists/presentation/cubit/checklist_state.dart';
import 'package:mobile/features/checklists/data/models/checklist_model.dart';
import 'package:mobile/core/di/service_locator.dart';

class ChecklistsPage extends StatefulWidget {
  final UserModel user;
  final VehicleModel? vehicle;

  const ChecklistsPage({super.key, required this.user, this.vehicle});

  @override
  State<ChecklistsPage> createState() => _ChecklistsPageState();
}

class _KeyboardDismissOnTap extends StatelessWidget {
  final Widget child;
  const _KeyboardDismissOnTap({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}

class _ChecklistsPageState extends State<ChecklistsPage> {
  late final ChecklistCubit _checklistCubit;
  final Set<String> _completedChecklistIds = {};
  List<ChecklistModel> _checklists = [];

  @override
  void initState() {
    super.initState();
    _checklistCubit = sl<ChecklistCubit>();
    _checklistCubit.loadChecklists();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _checklistCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CHECKLISTS DE INGRESO'),
          backgroundColor: const Color(0xFF1E293B),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
              tooltip: 'Cerrar Sesión',
              onPressed: () => _showLogoutDialog(context),
            ),
          ],
        ),
        body: BlocConsumer<ChecklistCubit, ChecklistState>(
          listener: (context, state) {
            if (state is ChecklistSubmitSuccess) {
              // El último checklist enviado se completó con éxito
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Checklist completado y guardado localmente.'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ChecklistLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ChecklistSubmitBlocked) {
              return _buildBlockedScreen(state.reason);
            }

            if (state is ChecklistError) {
              return _buildErrorScreen(state.message);
            }

            if (state is ChecklistsLoaded) {
              _checklists = state.checklists;
            }

            return _buildChecklistsListScreen();
          },
        ),
      ),
    );
  }

  // Pantalla de Bloqueo Crítico
  Widget _buildBlockedScreen(String reason) {
    return Container(
      color: const Color(0xFF450A0A),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.security_update_warning_rounded,
            size: 80,
            color: Colors.redAccent,
          ),
          const SizedBox(height: 24),
          const Text(
            'INGRESO RECHAZADO',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
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
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pop(); // Volver a la pantalla de verificación
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'VOLVER',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorScreen(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _checklistCubit.loadChecklists(),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  // Pantalla con los 4 checklists
  Widget _buildChecklistsListScreen() {
    final allCompleted =
        _completedChecklistIds.length >= _checklists.length &&
        _checklists.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Completa los 4 checklists de seguridad obligatorios antes de iniciar tu ruta del día.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: _checklists.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final cl = _checklists[index];
                final isCompleted = _completedChecklistIds.contains(cl.id);
                return _buildChecklistCard(cl, isCompleted);
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: allCompleted
                ? () {
                    // Finaliza los 4 checklists obligatorios y pasa al escaneo del camión
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Row(
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                            ),
                            SizedBox(width: 10),
                            Text('¡Checklists Aprobados!'),
                          ],
                        ),
                        content: const Text(
                          'Felicidades. Has completado exitosamente los 4 controles de seguridad obligatorios.\n\nA continuación, debes escanear el código QR del vehículo/camión asignado.',
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      VerificationPage(user: widget.user),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('ESCANEAR VEHÍCULO / CAMIÓN'),
                          ),
                        ],
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.withValues(alpha: 0.12),
              disabledForegroundColor: Colors.grey.withValues(alpha: 0.38),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              allCompleted
                  ? 'APROBAR CHECKLISTS Y ESCANEAR CAMIÓN'
                  : 'COMPLETA TODOS LOS CHECKLISTS',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistCard(ChecklistModel cl, bool isCompleted) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isCompleted
                ? Colors.green.withValues(alpha: 0.15)
                : Colors.blueAccent.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted
                ? Icons.check_circle_rounded
                : Icons.playlist_add_check_rounded,
            color: isCompleted ? Colors.green : Colors.blueAccent,
            size: 28,
          ),
        ),
        title: Text(
          cl.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          cl.description ?? '',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: isCompleted
            ? const Chip(
                label: Text(
                  'LISTO',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.green,
                labelStyle: TextStyle(color: Colors.white),
              )
            : const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: isCompleted
            ? null
            : () {
                _openChecklistForm(cl);
              },
      ),
    );
  }

  // Abre el formulario dinámico para rellenar las preguntas
  void _openChecklistForm(ChecklistModel cl) {
    final Map<String, String> answers = {};
    final Map<String, String?> answerPhotos = {};

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return _KeyboardDismissOnTap(
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              cl.title.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cl.questions.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          final q = cl.questions[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${index + 1}. ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      q.questionText,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  if (q.isCritical)
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Chip(
                                        label: Text(
                                          'CRÍTICO',
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        backgroundColor: Colors.red,
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              _buildQuestionInput(
                                q,
                                answers,
                                answerPhotos,
                                setModalState,
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          // Validar que todas las requeridas estén respondidas
                          final allAnswered = cl.questions.every((q) {
                            if (!q.isRequired) return true;
                            return answers.containsKey(q.id) &&
                                answers[q.id]!.isNotEmpty;
                          });

                          if (!allAnswered) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Por favor, responde todas las preguntas obligatorias.',
                                ),
                                backgroundColor: Colors.orange,
                              ),
                            );
                            return;
                          }

                          Navigator.pop(context); // Cerrar Modal

                          // Ejecutar envío en el cubit principal
                          _checklistCubit
                              .submitAnswers(
                                checklistId: cl.id,
                                answers: answers,
                                answerPhotos: answerPhotos,
                                questions: cl.questions,
                                vehicleId: widget.vehicle?.id ?? 'CAMION-001',
                              )
                              .then((_) {
                                // Si se completó correctamente, marcar ID
                                if (_checklistCubit.state
                                        is! ChecklistSubmitBlocked &&
                                    _checklistCubit.state is! ChecklistError) {
                                  setState(() {
                                    _completedChecklistIds.add(cl.id);
                                  });
                                }
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'ENVIAR RESPUESTAS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Dibuja los diferentes inputs dinámicos de las preguntas
  Widget _buildQuestionInput(
    ChecklistQuestionModel q,
    Map<String, String> answers,
    Map<String, String?> answerPhotos,
    void Function(void Function()) setModalState,
  ) {
    if (q.questionType == 'YES_NO') {
      final value = answers[q.id] ?? '';
      return Row(
        children: [
          Expanded(
            child: ChoiceChip(
              label: const Center(child: Text('SÍ')),
              selected: value == 'SÍ',
              selectedColor: Colors.green.withValues(alpha: 0.3),
              checkmarkColor: Colors.green,
              onSelected: (selected) {
                if (selected) {
                  setModalState(() => answers[q.id] = 'SÍ');
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ChoiceChip(
              label: const Center(child: Text('NO')),
              selected: value == 'NO',
              selectedColor: Colors.red.withValues(alpha: 0.3),
              checkmarkColor: Colors.red,
              onSelected: (selected) {
                if (selected) {
                  setModalState(() => answers[q.id] = 'NO');
                }
              },
            ),
          ),
        ],
      );
    }

    if (q.questionType == 'PHOTO') {
      final hasPhoto = answerPhotos[q.id] != null;
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () async {
                // Simulación de toma de foto offline
                // Creamos un archivo dummy en el almacenamiento local para simular la captura de cámara
                try {
                  final directory = await getTemporaryDirectory();
                  final path = p.join(
                    directory.path,
                    'photo_${DateTime.now().millisecondsSinceEpoch}.jpg',
                  );
                  final file = File(path);
                  await file.writeAsString(
                    'dummy_photo_data',
                  ); // Simula archivo de imagen

                  setModalState(() {
                    answerPhotos[q.id] = path;
                    answers[q.id] = 'Foto adjunta: ${p.basename(path)}';
                  });
                } catch (_) {}
              },
              icon: Icon(
                hasPhoto ? Icons.check_circle : Icons.camera_alt_outlined,
                color: hasPhoto ? Colors.green : Colors.grey,
              ),
              label: Text(
                hasPhoto ? 'FOTO CARGADA' : 'TOMAR FOTOGRAFÍA OBLIGATORIA',
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(
                  color: hasPhoto
                      ? Colors.green
                      : Colors.grey.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return TextFormField(
      onChanged: (val) => answers[q.id] = val,
      decoration: InputDecoration(
        hintText: 'Escribe tu respuesta aquí...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text(
          '¿Estás seguro de que deseas cerrar sesión? Perderás el avance de los checklists no enviados.',
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
}
