import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pantallas/login.dart';
import 'pantallas/registro.dart';
import 'pantallas/inicio.dart';
import 'pantallas/detalle_gasto.dart';
import 'pantallas/detalle_ingreso.dart';
import 'pantallas/presupuesto.dart';
import 'pantallas/cambiar_contrasena.dart';
import 'pantallas/lista_gastos.dart';
import 'pantallas/lista_ingresos.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const FinanTrackApp());
}

class FinanTrackApp extends StatelessWidget {
  const FinanTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinanTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFF0D0D2B),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C63FF),
          secondary: Color(0xFF48C6EF),
          surface: Color(0xFF1A1A40),
          error: Color(0xFFEF5350),
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/registro': (context) => const RegistroScreen(),
        '/inicio': (context) => const InicioScreen(),
        '/detalle_gasto': (context) => const DetalleGastoScreen(),
        '/detalle_ingreso': (context) => const DetalleIngresoScreen(),
        '/presupuesto': (context) => const PresupuestoScreen(),
        '/cambiar_contrasena': (context) => const CambiarContrasenaScreen(),
        '/lista_gastos': (context) => const ListaGastosScreen(),
        '/lista_ingresos': (context) => const ListaIngresosScreen(),
      },
    );
  }
}
