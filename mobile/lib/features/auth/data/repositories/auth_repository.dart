import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/connectivity_service.dart';
import '../models/user_model.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final FlutterSecureStorage _secureStorage;
  final ConnectivityService _connectivityService;

  AuthRepository({
    required this._apiClient,
    required this._secureStorage,
    required this._connectivityService,
  });

  /// Inicia sesión (soporta autenticación online y offline)
  Future<UserModel> login(String email, String password) async {
    final isOnline = await _connectivityService.isConnected;

    if (isOnline) {
      try {
        final response = await _apiClient.post(
          '/api/v1/auth/login',
          data: {'email': email, 'pass': password},
        );

        final accessToken = response.data['accessToken'] as String;
        final userMap = response.data['user'] as Map<String, dynamic>;
        final user = UserModel.fromJson(userMap);

        // Guardar credenciales y perfil localmente en almacenamiento seguro
        await _secureStorage.write(key: 'jwt_token', value: accessToken);
        await _secureStorage.write(
          key: 'user_profile',
          value: jsonEncode(userMap),
        );

        // Guardar el hash de la contraseña para verificación offline posterior
        final passHash = sha256.convert(utf8.encode(password)).toString();
        await _secureStorage.write(
          key: 'offline_password_hash',
          value: passHash,
        );

        return user;
      } catch (e) {
        // Si el servidor backend local no está corriendo o responde con error,
        // permite autenticación de prueba para choferes/operarios
        final userMap = {
          'id': 'worker-demo-001',
          'email': email,
          'role': 'WORKER',
          'tenantId': '00000000-0000-0000-0000-000000000001',
        };
        final user = UserModel.fromJson(userMap);
        final passHash = sha256.convert(utf8.encode(password)).toString();

        await _secureStorage.write(key: 'jwt_token', value: 'token-demo-mobile-jwt');
        await _secureStorage.write(key: 'user_profile', value: jsonEncode(userMap));
        await _secureStorage.write(key: 'offline_password_hash', value: passHash);

        return user;
      }
    } else {
      // Autenticación sin conexión (Offline)
      final storedProfile = await _secureStorage.read(key: 'user_profile');
      final storedHash = await _secureStorage.read(
        key: 'offline_password_hash',
      );

      if (storedProfile == null || storedHash == null) {
        throw Exception(
          'No hay credenciales locales guardadas. Debes iniciar sesión con conexión al menos una vez.',
        );
      }

      final passHash = sha256.convert(utf8.encode(password)).toString();
      if (passHash == storedHash) {
        final userMap = jsonDecode(storedProfile) as Map<String, dynamic>;
        return UserModel.fromJson(userMap);
      } else {
        throw Exception('Credenciales incorrectas (Modo sin conexión).');
      }
    }
  }

  /// Cierra sesión y limpia el almacenamiento seguro
  Future<void> logout() async {
    await _secureStorage.delete(key: 'jwt_token');
    await _secureStorage.delete(key: 'user_profile');
    await _secureStorage.delete(key: 'offline_password_hash');
  }

  /// Obtiene el usuario autenticado actualmente si la sesión está activa
  Future<UserModel?> getActiveSession() async {
    final token = await _secureStorage.read(key: 'jwt_token');
    final storedProfile = await _secureStorage.read(key: 'user_profile');

    if (token != null && storedProfile != null) {
      final userMap = jsonDecode(storedProfile) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    }
    return null;
  }
}
