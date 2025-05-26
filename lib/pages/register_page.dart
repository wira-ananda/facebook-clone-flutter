import 'package:flutter/material.dart';
import '../services/auth_service.dart'; // Sesuaikan dengan path proyekmu

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _authService = AuthService();

  // Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController phoneOrEmailController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? gender; // "L" or "P"
  int _currentStep = 0;

  void _submitRegistration() async {
    final username = "${firstNameController.text} ${lastNameController.text}";
    final phone = phoneOrEmailController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final birthday =
        "${yearController.text}-${monthController.text.padLeft(2, '0')}-${dayController.text.padLeft(2, '0')}";

    await _authService.registerUser(
      username: username,
      email: email,
      phone: phone,
      birthday: birthday,
      gender: gender ?? '',
      password: password,
      passwordConfirmation: password,
      onSuccess: () => Navigator.pushReplacementNamed(context, '/login'),
      onError:
          (message) => ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message))),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    phoneOrEmailController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Align(
        alignment: isMobile ? Alignment.topCenter : Alignment.center,
        child: Container(
          width: isMobile ? double.infinity : 600,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'facebook',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
                const Text(
                  'Buat Akun Baru',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Ini cepat dan mudah.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),

                if (isMobile) ...[
                  _buildMobileStep(_currentStep),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _currentStep < 3 ? Colors.blue : Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          if (_currentStep < 3) {
                            setState(() => _currentStep++);
                          } else {
                            _submitRegistration();
                          }
                        },
                        child: Text(
                          _currentStep < 3 ? 'Berikutnya' : 'Daftar',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  _buildDesktopForm(),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: _submitRegistration,
                        child: const Text(
                          'Daftar',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileStep(int step) {
    switch (step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'Nama depan'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Nama belakang'),
            ),
          ],
        );
      case 1:
        return Row(
          children: [
            Expanded(
              child: TextField(
                controller: dayController,
                decoration: InputDecoration(labelText: 'Tanggal'),
              ),
            ),
            Expanded(
              child: TextField(
                controller: monthController,
                decoration: InputDecoration(labelText: 'Bulan'),
              ),
            ),
            Expanded(
              child: TextField(
                controller: yearController,
                decoration: InputDecoration(labelText: 'Tahun'),
              ),
            ),
          ],
        );
      case 2:
        return Row(
          children: [
            Radio<String>(
              value: 'P',
              groupValue: gender,
              onChanged: (val) => setState(() => gender = val),
            ),
            const Text('Perempuan'),
            Radio<String>(
              value: 'L',
              groupValue: gender,
              onChanged: (val) => setState(() => gender = val),
            ),
            const Text('Laki-laki'),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: phoneOrEmailController,
              decoration: InputDecoration(labelText: 'Nomor seluler'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Kata sandi baru'),
            ),
          ],
        );
      default:
        return Container();
    }
  }

  Widget _buildDesktopForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: firstNameController,
          decoration: InputDecoration(labelText: 'Nama depan'),
        ),
        TextField(
          controller: lastNameController,
          decoration: InputDecoration(labelText: 'Nama belakang'),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: dayController,
                decoration: InputDecoration(labelText: 'Tanggal'),
              ),
            ),
            Expanded(
              child: TextField(
                controller: monthController,
                decoration: InputDecoration(labelText: 'Bulan'),
              ),
            ),
            Expanded(
              child: TextField(
                controller: yearController,
                decoration: InputDecoration(labelText: 'Tahun'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              value: 'P',
              groupValue: gender,
              onChanged: (val) => setState(() => gender = val),
            ),
            const Text('Perempuan'),
            Radio<String>(
              value: 'L',
              groupValue: gender,
              onChanged: (val) => setState(() => gender = val),
            ),
            const Text('Laki-laki'),
          ],
        ),
        TextField(
          controller: phoneOrEmailController,
          decoration: InputDecoration(labelText: 'Nomor seluler'),
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(labelText: 'Kata sandi baru'),
        ),
      ],
    );
  }
}
