import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class AuthService {
  // ANDROID EMULATOR
  // final String baseUrl = 'http://10.0.2.2:8000';
  // FLUTTER WEB
  final String baseUrl = 'http://localhost:8000';

  final Logger _logger = Logger();

  Future<void> registerUser(
    String username,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    var url = Uri.parse('$baseUrl/api/auth/register');

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
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      if (response.statusCode == 201) {
        _logger.i("Registrasi berhasil: ${response.body}");
      } else {
        _logger.w("Registrasi gagal: ${response.body}");
      }
    } catch (e, s) {
      _logger.e("Exception saat register", error: e, stackTrace: s);
    }
  }

  Future<bool> loginUser(String email, String password) async {
    var url = Uri.parse('$baseUrl/api/auth/login');

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
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
