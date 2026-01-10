import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

extension JollyPodcastColorScheme on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension ScreenDimensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}

class AppSecureStorage {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  Future<void> saveUserId(String userId) async {
    await _secureStorage.write(key: _userIdKey, value: userId);
  }

  Future<String?> getUserId() async {
    return await _secureStorage.read(key: _userIdKey);
  }

  Future<void> clearToken() async {
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _userIdKey);
  }

  Future<bool> isTokenAvailable() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
