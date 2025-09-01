import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavbar(),
      body: Center(
        child: Text(
          'Bienvenido a la pantalla principal',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
