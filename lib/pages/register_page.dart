import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _currentStep = 0; // Step indicator for mobile
  final List<Widget> _steps = [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(decoration: InputDecoration(labelText: 'Nama depan')),
        TextField(decoration: InputDecoration(labelText: 'Nama belakang')),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(decoration: InputDecoration(labelText: 'Tanggal Lahir')),
        TextField(decoration: InputDecoration(labelText: 'Bulan')),
        TextField(decoration: InputDecoration(labelText: 'Tahun')),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Radio(value: 'Perempuan', groupValue: null, onChanged: null),
            Text('Perempuan'),
            Radio(value: 'Laki-laki', groupValue: null, onChanged: null),
            Text('Laki-laki'),
            Radio(value: 'Kustom', groupValue: null, onChanged: null),
            Text('Kustom'),
          ],
        ),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(labelText: 'Nomor seluler atau email'),
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Kata sandi baru'),
          obscureText: true,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bool isMobile =
        MediaQuery.of(context).size.width < 600; // Detect mobile devices

    return Scaffold(
      body: Center(
        child: Container(
          width:
              isMobile
                  ? double.infinity
                  : 600, // Full width for mobile, fixed width for desktop
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.center,
                  child: const Text(
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

                // Mobile step-by-step navigation
                if (isMobile) ...[
                  _steps[_currentStep], // Show current step
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentStep < _steps.length - 1) {
                        setState(() {
                          _currentStep++;
                        });
                      } else {
                        Navigator.pushReplacementNamed(
                          context,
                          '/', // Navigate to homepage
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      _currentStep < _steps.length - 1
                          ? 'Berikutnya'
                          : 'Daftar',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],

                // Desktop layout (all fields visible)
                if (!isMobile) ...[
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(labelText: 'Nama depan'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Nama belakang'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Tanggal Lahir',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Bulan'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Tahun'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Jenis Kelamin'),
                      Row(
                        children: [
                          Radio(
                            value: 'Perempuan',
                            groupValue: null,
                            onChanged: null,
                          ),
                          Text('Perempuan'),
                          Radio(
                            value: 'Laki-laki',
                            groupValue: null,
                            onChanged: null,
                          ),
                          Text('Laki-laki'),
                          Radio(
                            value: 'Kustom',
                            groupValue: null,
                            onChanged: null,
                          ),
                          Text('Kustom'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nomor seluler atau email',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Kata sandi baru'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/', // Navigate to homepage
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Daftar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text('Sudah memiliki akun?'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
