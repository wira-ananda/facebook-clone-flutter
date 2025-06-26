import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class AuthService {
  // ANDROID EMULATOR
  // final String baseUrl = 'http://10.0.2.2:8000';
  // FLUTTER WEB
  final String baseUrl = 'http://localhost:8000';

  final Logger _logger = Logger();

  Future<void> registerUser({
    required String username,
    required String email,
    required String phone,
    required String birthday,
    required String gender,
    required String password,
    required String passwordConfirmation,
    required Function() onSuccess,
    required Function(String message) onError,
  }) async {
    final url = Uri.parse('$baseUrl/api/auth/register');

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'email': email,
          'phone': phone,
          'birthday': birthday,
          'gender': gender,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      if (response.statusCode == 201) {
        _logger.i("Registrasi berhasil: ${response.body}");
        onSuccess();
      } else {
        final body = response.body;
        dynamic data;

        try {
          data = jsonDecode(body);
        } catch (e) {
          _logger.w("Gagal parse JSON: $body");
          onError("Terjadi kesalahan dari server.");
          return;
        }

        final message =
            data is Map && data['message'] is String
                ? data['message']
                : 'Registrasi gagal';

        _logger.w("Registrasi gagal: ${jsonEncode(data)}");
        onError(message);
      }
    } catch (e, s) {
      _logger.e("Exception saat register", error: e, stackTrace: s);
      onError("Terjadi kesalahan saat mengirim data.");
    }
  }

  Future<bool> loginUser(String login, String password) async {
    var url = Uri.parse('$baseUrl/api/auth/login');

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'login': login, 'password': password}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        _logger.i("Login berhasil! User: ${data['user']['username']}");
        return true;
      } else {
        _logger.w("Login gagal: ${response.body}");
        return false;
      }
    } catch (e, s) {
      _logger.e("Exception saat login", error: e, stackTrace: s);
      return false;
    }
  }
}
