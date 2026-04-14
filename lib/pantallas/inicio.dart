import 'package:flutter/material.dart';
import '../datos/datos_usuario.dart';
import '../datos/diccionario_gastos.dart';
import '../datos/diccionario_ingresos.dart';
import 'resumen.dart';
import 'captura_gasto.dart';
import 'captura_ingreso.dart';
import 'perfil.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  int _indiceActual = 0;

  final List<Widget> _pantallas = [
    const ResumenScreen(),
    const CapturaGastoScreen(),
    const CapturaIngresoScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D0D2B),
              Color(0xFF1A1A40),
            ],
          ),
        ),
        child: _pantallas[_indiceActual],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A40),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C63FF).withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _indiceActual,
          onTap: (index) {
            setState(() {
              _indiceActual = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF1A1A40),
          selectedItemColor: const Color(0xFF6C63FF),
          unselectedItemColor: Colors.white.withOpacity(0.4),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              activeIcon: Icon(Icons.dashboard_rounded, size: 28),
              label: 'Resumen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.remove_circle_outline),
              activeIcon: Icon(Icons.remove_circle, size: 28),
              label: 'Gastos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle, size: 28),
              label: 'Ingresos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person, size: 28),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
