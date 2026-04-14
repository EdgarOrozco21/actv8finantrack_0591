import 'package:flutter/material.dart';
import '../datos/datos_usuario.dart';

class CambiarContrasenaScreen extends StatefulWidget {
  const CambiarContrasenaScreen({super.key});

  @override
  State<CambiarContrasenaScreen> createState() => _CambiarContrasenaScreenState();
}

class _CambiarContrasenaScreenState extends State<CambiarContrasenaScreen> {
  final _actualController = TextEditingController();
  final _nuevaController = TextEditingController();
  final _confirmarController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _ocultarActual = true;
  bool _ocultarNueva = true;
  bool _ocultarConfirmar = true;

  @override
  void dispose() {
    _actualController.dispose();
    _nuevaController.dispose();
    _confirmarController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(String label, IconData icon, {required bool ocultar, required VoidCallback toggle}) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.7)),
      suffixIcon: IconButton(
        icon: Icon(
          ocultar ? Icons.visibility_off : Icons.visibility,
          color: Colors.white.withOpacity(0.7),
        ),
        onPressed: toggle,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFEF5350)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFEF5350), width: 2),
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
    );
  }

  void _cambiar() {
    if (_formKey.currentState!.validate()) {
      final exito = cambiarContrasena(
        usuarioActualEmail!,
        _actualController.text,
        _nuevaController.text,
      );

      if (exito) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('¡Contraseña actualizada!'),
              ],
            ),
            backgroundColor: const Color(0xFF00C853),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white),
                SizedBox(width: 12),
                Text('Contraseña actual incorrecta'),
              ],
            ),
            backgroundColor: const Color(0xFFEF5350),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D0D2B), Color(0xFF1A1A40)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    const Text(
                      'Cambiar Contraseña',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Icono
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6C63FF), Color(0xFF8338EC)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6C63FF).withOpacity(0.3),
                              blurRadius: 25,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.lock_reset,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),

                      Text(
                        'Ingresa tu contraseña actual y la nueva',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 32),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _actualController,
                              obscureText: _ocultarActual,
                              style: const TextStyle(color: Colors.white),
                              decoration: _buildInputDecoration(
                                'Contraseña actual',
                                Icons.lock_outline,
                                ocultar: _ocultarActual,
                                toggle: () => setState(() => _ocultarActual = !_ocultarActual),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Ingresa tu contraseña actual';
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            TextFormField(
                              controller: _nuevaController,
                              obscureText: _ocultarNueva,
                              style: const TextStyle(color: Colors.white),
                              decoration: _buildInputDecoration(
                                'Nueva contraseña',
                                Icons.lock,
                                ocultar: _ocultarNueva,
                                toggle: () => setState(() => _ocultarNueva = !_ocultarNueva),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Ingresa la nueva contraseña';
                                if (value.length < 6) return 'Mínimo 6 caracteres';
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            TextFormField(
                              controller: _confirmarController,
                              obscureText: _ocultarConfirmar,
                              style: const TextStyle(color: Colors.white),
                              decoration: _buildInputDecoration(
                                'Confirmar nueva contraseña',
                                Icons.lock,
                                ocultar: _ocultarConfirmar,
                                toggle: () => setState(() => _ocultarConfirmar = !_ocultarConfirmar),
                              ),
                              validator: (value) {
                                if (value != _nuevaController.text) return 'Las contraseñas no coinciden';
                                return null;
                              },
                            ),
                            const SizedBox(height: 32),

                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: _cambiar,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6C63FF),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  elevation: 8,
                                  shadowColor: const Color(0xFF6C63FF).withOpacity(0.4),
                                ),
                                child: const Text(
                                  'Cambiar Contraseña',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
