import 'package:biometric_app/pages/home_page.dart';
import 'package:biometric_app/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  static const biometricChanel = MethodChannel('auth_app.com/biometric');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Аутентифікаця'),
            const SizedBox(height: 50),
            AuthButton(
              title: 'відбитка',
              onPressed: _onBiometricPressed,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onBiometricPressed() async {
    final res = await biometricChanel.invokeMethod('showBiomtericLogin');
    if (res) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }
}
