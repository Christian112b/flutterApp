import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {

  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return AppBar(
      backgroundColor: const Color(0xFFFFFFFF), // fondo blanco
      elevation: 4,
      titleSpacing: 0,
      title: Row(
        children: [
          const SizedBox(width: 16),
          // Logo + nombre
          Row(
            children: [
              Image.asset('assets/images/logo.png', height: 50),
              const SizedBox(width: 32),
              Text(
                "",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const Spacer(),

          // Enlaces centrados (solo en web/tablet)
          if (!isMobile)
            Row(
              children: [
                _NavLink(label: 'eBikes', onTap: () {}),
                _NavLink(label: 'Category', onTap: () {}, hasDropdown: true),
                _NavLink(label: 'Experience Center', onTap: () {}),
                _NavLink(label: 'About', onTap: () {}),
              ],
            ),

          const Spacer(),

          // Íconos a la derecha
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black87),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black87,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person_outline, color: Colors.black87),
                onPressed: () => Navigator.pushNamed(context, '/login'),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool hasDropdown;

  const _NavLink({
    required this.label,
    required this.onTap,
    this.hasDropdown = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Colors.black87)),
          if (hasDropdown)
            const Icon(Icons.arrow_drop_down, color: Colors.black87),
        ],
      ),
    );
  }
}
