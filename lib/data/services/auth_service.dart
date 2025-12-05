import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  static const String _biometricKey = 'biometric_enabled';

  // Mock authentication - in production, integrate with actual auth providers
  Future<UserModel?> authenticateUser(String email, String password) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock successful authentication
      if (email.isNotEmpty && password.isNotEmpty) {
        final user = UserModel(
          id: 'user_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
          firstName: 'John',
          lastName: 'Doe',
          phoneNumber: '+1234567890',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isVerified: true,
          permissions: ['read', 'write', 'transfer'],
          biometricData: BiometricData(
            fingerprintHash: 'fp_hash_${DateTime.now().millisecondsSinceEpoch}',
            faceHash: 'face_hash_${DateTime.now().millisecondsSinceEpoch}',
            isFingerprintEnabled: true,
            isFaceEnabled: true,
            lastAuthenticated: DateTime.now(),
          ),
        );

        await _saveUserData(user);
        await _saveAuthToken(
            'mock_token_${DateTime.now().millisecondsSinceEpoch}');

        return user;
      }

      return null;
    } catch (e) {
      throw Exception('Authentication failed: ${e.toString()}');
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      // Simulate biometric authentication
      await Future.delayed(const Duration(milliseconds: 800));

      final prefs = await SharedPreferences.getInstance();
      final biometricEnabled = prefs.getBool(_biometricKey) ?? false;

      if (biometricEnabled) {
        // Mock successful biometric authentication
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> enableBiometricAuth() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_biometricKey, true);
    } catch (e) {
      throw Exception(
          'Failed to enable biometric authentication: ${e.toString()}');
    }
  }

  Future<void> disableBiometricAuth() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_biometricKey, false);
    } catch (e) {
      throw Exception(
          'Failed to disable biometric authentication: ${e.toString()}');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);

      if (userJson != null) {
        final userMap = json.decode(userJson);
        return UserModel.fromJson(userMap);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getAuthToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      await prefs.remove(_userKey);
      await prefs.remove(_biometricKey);
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  Future<void> _saveUserData(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = json.encode(user.toJson());
      await prefs.setString(_userKey, userJson);
    } catch (e) {
      throw Exception('Failed to save user data: ${e.toString()}');
    }
  }

  Future<void> _saveAuthToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
    } catch (e) {
      throw Exception('Failed to save auth token: ${e.toString()}');
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final token = await getAuthToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> refreshToken() async {
    try {
      // Simulate token refresh
      await Future.delayed(const Duration(milliseconds: 500));

      final newToken =
          'refreshed_token_${DateTime.now().millisecondsSinceEpoch}';
      await _saveAuthToken(newToken);

      return true;
    } catch (e) {
      return false;
    }
  }
}
