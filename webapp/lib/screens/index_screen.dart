import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  String responseMessage = '';

  Future<void> sendToFlask() async {
    final url = Uri.parse('http://localhost:5000/api/test'); // Cambia si usas Render
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': 'Hola desde Flutter'}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          responseMessage = data['echo']['message'] ?? 'Sin respuesta';
        });
      } else {
        setState(() {
          responseMessage = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        responseMessage = 'Error de conexión: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla de Inicio')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: sendToFlask,
              child: const Text('Enviar a Flask'),
            ),
            const SizedBox(height: 20),
            Text(responseMessage),
          ],
        ),
      ),
    );
  }
}
