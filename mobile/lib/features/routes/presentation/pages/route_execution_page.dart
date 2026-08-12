import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../auth/data/models/user_model.dart';
import '../cubit/routes_cubit.dart';
import '../cubit/routes_state.dart';
import '../../data/models/route_model.dart';
import 'route_map_page.dart';
import '../../../../core/di/service_locator.dart';

class RouteExecutionPage extends StatefulWidget {
  final RouteModel route;
  final UserModel user;

  const RouteExecutionPage({
    super.key,
    required this.route,
    required this.user,
  });

  @override
  State<RouteExecutionPage> createState() => _RouteExecutionPageState();
}

class _RouteExecutionPageState extends State<RouteExecutionPage> {
  late final RoutesCubit _routesCubit;
  late RouteModel _currentRoute;

  @override
  void initState() {
    super.initState();
    _routesCubit = sl<RoutesCubit>();
    _currentRoute = widget.route;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _routesCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_currentRoute.name),
          backgroundColor: const Color(0xFF1E293B),
          actions: [
            IconButton(
              icon: const Icon(Icons.map_rounded),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RouteMapPage(route: _currentRoute),
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<RoutesCubit, RoutesState>(
          listener: (context, state) {
            if (state is RoutesLoaded) {
              // Actualizar el estado de la ruta actual desde el state de cubit
              setState(() {
                _currentRoute = state.routes.firstWhere(
                  (r) => r.id == _currentRoute.id,
                );
              });
            } else if (state is RouteActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Operación registrada y encolada con éxito.'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is RouteActionLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final points = _currentRoute.points;
            final isPendingStart = _currentRoute.status == 'PENDING';
            final isCompleted = _currentRoute.status == 'COMPLETED';

            // Identificar el índice del primer punto pendiente (flujo secuencial estricto)
            int activePointIndex = -1;
            for (int i = 0; i < points.length; i++) {
              if (points[i].status == 'PENDING') {
                activePointIndex = i;
                break;
              }
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Encabezado
                  _buildHeaderCard(),
                  const SizedBox(height: 20),
                  const Text(
                    'PUNTOS DE CONTROL EN SECUENCIA',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Lista de Puntos (Timeline)
                  Expanded(
                    child: ListView.builder(
                      itemCount: points.length,
                      itemBuilder: (context, index) {
                        final point = points[index];
                        final isUnlocked =
                            !isPendingStart && index == activePointIndex;
                        final isProcessed = point.status != 'PENDING';
                        return _buildTimelineItem(
                          point,
                          index,
                          isUnlocked,
                          isProcessed,
                        );
                      },
                    ),
                  ),

                  // Botón de Acción (Iniciar o Finalizar Ruta)
                  const SizedBox(height: 20),
                  if (isPendingStart)
                    ElevatedButton.icon(
                      onPressed: () {
                        _routesCubit.startRoute(
                          _currentRoute.id,
                          widget.user.id,
                        );
                      },
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('INICIAR RUTA (GPS)'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  else if (activePointIndex == -1 && !isCompleted)
                    ElevatedButton.icon(
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        await _routesCubit.finishRoute(_currentRoute.id, widget.user.id);
                        if (mounted) {
                          navigator.pop();
                        }
                      },
                      icon: const Icon(Icons.check_circle_rounded),
                      label: const Text('FINALIZAR RUTA (CÁLCULO KPI)'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  else if (isCompleted)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.green.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 10),
                          Text(
                            'Ruta completada con éxito hoy.',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cliente: ${_currentRoute.clientName}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              'Faena: ${_currentRoute.faenaName}',
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Puntos: ${_currentRoute.points.length}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'Completado: ${_currentRoute.completionPercentage.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
    RoutePointModel point,
    int index,
    bool isUnlocked,
    bool isProcessed,
  ) {
    Color iconColor = Colors.grey;
    IconData icon = Icons.lock_outline_rounded;

    if (point.status == 'COMPLETED') {
      iconColor = Colors.green;
      icon = Icons.check_circle_rounded;
    } else if (point.status == 'OMITTED') {
      iconColor = Colors.orange;
      icon = Icons.skip_next_rounded;
    } else if (isUnlocked) {
      iconColor = Colors.blueAccent;
      icon = Icons.play_circle_outline_rounded;
    }

    return IntrinsicHeight(
      child: Row(
        children: [
          // Conectores del Timeline
          Column(
            children: [
              Container(
                width: 2,
                height: 10,
                color: index == 0
                    ? Colors.transparent
                    : Colors.grey.withValues(alpha: 0.3),
              ),
              Icon(icon, color: iconColor, size: 28),
              Expanded(
                child: Container(
                  width: 2,
                  color: index == _currentRoute.points.length - 1
                      ? Colors.transparent
                      : Colors.grey.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Contenido del Punto
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Card(
                color: isUnlocked
                    ? const Color(0xFF1E293B)
                    : const Color(0xFF0F172A).withValues(alpha: 0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: isUnlocked
                        ? Colors.blueAccent
                        : Colors.grey.withValues(alpha: 0.1),
                    width: isUnlocked ? 1.5 : 1,
                  ),
                ),
                child: ListTile(
                  title: Text(
                    point.name,
                    style: TextStyle(
                      fontWeight: isUnlocked
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isUnlocked
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                  subtitle: Text(
                    'Punto de Control ${index + 1}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.withValues(alpha: 0.6),
                    ),
                  ),
                  trailing: isUnlocked
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.skip_next_rounded,
                                color: Colors.orangeAccent,
                              ),
                              tooltip: 'Omitir punto',
                              onPressed: () => _showOmitConfirmation(point),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: Colors.blueAccent,
                            ),
                          ],
                        )
                      : null,
                  onTap: isUnlocked
                      ? () {
                          _openVisitSheet(point);
                        }
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOmitConfirmation(RoutePointModel point) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('¿Omitir Punto?'),
          content: Text(
            '¿Estás seguro de que deseas omitir la visita a "${point.name}"? Esto quedará registrado en la auditoría.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _routesCubit.omitPoint(
                  pointId: point.id,
                  routeId: _currentRoute.id,
                  workerId: widget.user.id,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Omitir'),
            ),
          ],
        );
      },
    );
  }

  // Formulario detallado de Atención de Punto
  void _openVisitSheet(RoutePointModel point) {
    String? photoBefore;
    String? photoAfter;
    final Map<String, dynamic> formData = {
      'toiletsCleaned': true,
      'chemicalRefilled': true,
      'soapReplenished': true,
      'observations': '',
    };
    final qrController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
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
                    Text(
                      'ATENCIÓN: ${point.name.toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 20),

                    // 1. Escaneo QR de presencia física
                    const Text(
                      '1. Validación de Presencia (Escanear QR del Punto)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: qrController,
                      decoration: InputDecoration(
                        labelText: 'Token QR del Punto',
                        hintText: point.qrCodeToken,
                        border: const OutlineInputBorder(),
                        suffixIcon: const Icon(Icons.qr_code_scanner),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 2. Foto Antes
                    const Text(
                      '2. Evidencia Inicial (Foto Antes)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () async {
                        try {
                          final dir = await getTemporaryDirectory();
                          final path = p.join(
                            dir.path,
                            'before_${DateTime.now().millisecondsSinceEpoch}.jpg',
                          );
                          await File(path).writeAsString('before_dummy_img');
                          setModalState(() => photoBefore = path);
                        } catch (_) {}
                      },
                      icon: Icon(
                        photoBefore != null
                            ? Icons.check_circle
                            : Icons.camera_alt_outlined,
                        color: photoBefore != null ? Colors.green : Colors.grey,
                      ),
                      label: Text(
                        photoBefore != null
                            ? 'FOTO ANTES CARGADA'
                            : 'TOMAR FOTO ANTES',
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 3. Tareas Operativas
                    const Text(
                      '3. Tareas Realizadas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SwitchListTile(
                      title: const Text(
                        '¿Baños limpios y sanitizados?',
                        style: TextStyle(fontSize: 13),
                      ),
                      value: formData['toiletsCleaned'],
                      onChanged: (val) =>
                          setModalState(() => formData['toiletsCleaned'] = val),
                    ),
                    SwitchListTile(
                      title: const Text(
                        '¿Recarga de producto químico?',
                        style: TextStyle(fontSize: 13),
                      ),
                      value: formData['chemicalRefilled'],
                      onChanged: (val) => setModalState(
                        () => formData['chemicalRefilled'] = val,
                      ),
                    ),
                    SwitchListTile(
                      title: const Text(
                        '¿Reposición de papel y jabón?',
                        style: TextStyle(fontSize: 13),
                      ),
                      value: formData['soapReplenished'],
                      onChanged: (val) => setModalState(
                        () => formData['soapReplenished'] = val,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Observaciones
                    TextField(
                      onChanged: (val) => formData['observations'] = val,
                      decoration: const InputDecoration(
                        labelText: 'Observaciones del servicio',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 4. Foto Después
                    const Text(
                      '4. Evidencia Final (Foto Después)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () async {
                        try {
                          final dir = await getTemporaryDirectory();
                          final path = p.join(
                            dir.path,
                            'after_${DateTime.now().millisecondsSinceEpoch}.jpg',
                          );
                          await File(path).writeAsString('after_dummy_img');
                          setModalState(() => photoAfter = path);
                        } catch (_) {}
                      },
                      icon: Icon(
                        photoAfter != null
                            ? Icons.check_circle
                            : Icons.camera_alt_outlined,
                        color: photoAfter != null ? Colors.green : Colors.grey,
                      ),
                      label: Text(
                        photoAfter != null
                            ? 'FOTO DESPUÉS CARGADA'
                            : 'TOMAR FOTO DESPUÉS',
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Registrar Visita
                    ElevatedButton(
                      onPressed: () {
                        final enteredToken = qrController.text.trim();
                        if (enteredToken != point.qrCodeToken) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'El código QR ingresado no corresponde al punto físico de control.',
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        if (photoBefore == null || photoAfter == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Debes capturar ambas fotografías (Antes y Después) para certificar el servicio.',
                              ),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          return;
                        }

                        Navigator.pop(context); // Cerrar bottom sheet

                        _routesCubit.visitPoint(
                          pointId: point.id,
                          routeId: _currentRoute.id,
                          workerId: widget.user.id,
                          photosBefore: [photoBefore!],
                          photosAfter: [photoAfter!],
                          formData: formData,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'ATENDER PUNTO Y SUBIR EVIDENCIAS',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
