import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _keepLoggedIn = false;

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final url = Uri.parse(
      'http://10.0.2.2:5000/api/login',
    ); // Cambia si usas Render

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': email, 'password': password}),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['success'] == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(data['message'])));

      // Aquí podrías navegar a otra pantalla
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? 'Error de login')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double widthFactor;

          if (constraints.maxWidth < 600) {
            // Pantallas pequeñas (móvil)
            widthFactor = 0.9;
          } else if (constraints.maxWidth < 1000) {
            // Pantallas medianas (tablet)
            widthFactor = 0.6;
          } else {
            // Pantallas grandes (web)
            widthFactor = 0.4;
          }

          return Center(
            child: FractionallySizedBox(
              widthFactor: widthFactor,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.email_outlined,
                          size: 64,
                          color: Colors.teal,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Inicia sesión",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 32),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "Usuario o correo electrónico",
                          ),
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            labelText: "Contraseña",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () => setState(
                                () => _showPassword = !_showPassword,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _keepLoggedIn,
                              onChanged: (val) =>
                                  setState(() => _keepLoggedIn = val!),
                            ),
                            Text("Mantener sesión iniciada"),
                          ],
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                          ),
                          child: Text("Ingresar"),
                        ),
                        SizedBox(height: 16),
                        TextButton(
                          onPressed: () {},
                          child: Text("¿Olvidaste tu contraseña?"),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("¿No puedes iniciar sesión?"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
