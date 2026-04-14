import 'package:flutter/material.dart';
import '../datos/datos_usuario.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> with SingleTickerProviderStateMixin {
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _confirmarController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _ocultarContrasena = true;
  bool _ocultarConfirmar = true;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _contrasenaController.dispose();
    _confirmarController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _registrar() {
    if (_formKey.currentState!.validate()) {
      final exito = registrarUsuario(
        _nombreController.text.trim(),
        _emailController.text.trim(),
        _contrasenaController.text,
      );
      if (exito) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('¡Cuenta creada exitosamente!'),
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
                Text('Este correo ya está registrado'),
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

  InputDecoration _buildInputDecoration(String label, IconData icon, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.7)),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D0D2B),
              Color(0xFF1A1A40),
              Color(0xFF2D2D6B),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Botón regresar
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Icono
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF48C6EF), Color(0xFF6C63FF)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF48C6EF).withOpacity(0.4),
                            blurRadius: 25,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person_add_alt_1,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Crear Cuenta',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ingresa tus datos para registrarte',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 36),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Nombre
                          TextFormField(
                            controller: _nombreController,
                            style: const TextStyle(color: Colors.white),
                            decoration: _buildInputDecoration('Nombre completo', Icons.person_outline),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa tu nombre';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Email
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            decoration: _buildInputDecoration('Correo electrónico', Icons.email_outlined),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa tu correo electrónico';
                              }
                              if (!value.contains('@')) {
                                return 'Ingresa un correo válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Contraseña
                          TextFormField(
                            controller: _contrasenaController,
                            obscureText: _ocultarContrasena,
                            style: const TextStyle(color: Colors.white),
                            decoration: _buildInputDecoration(
                              'Contraseña',
                              Icons.lock_outline,
                              suffix: IconButton(
                                icon: Icon(
                                  _ocultarContrasena ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                onPressed: () {
                                  setState(() => _ocultarContrasena = !_ocultarContrasena);
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa una contraseña';
                              }
                              if (value.length < 6) {
                                return 'La contraseña debe tener al menos 6 caracteres';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Confirmar contraseña
                          TextFormField(
                            controller: _confirmarController,
                            obscureText: _ocultarConfirmar,
                            style: const TextStyle(color: Colors.white),
                            decoration: _buildInputDecoration(
                              'Confirmar contraseña',
                              Icons.lock_outline,
                              suffix: IconButton(
                                icon: Icon(
                                  _ocultarConfirmar ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                onPressed: () {
                                  setState(() => _ocultarConfirmar = !_ocultarConfirmar);
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value != _contrasenaController.text) {
                                return 'Las contraseñas no coinciden';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),

                          // Botón Registrar
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _registrar,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF48C6EF),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 8,
                                shadowColor: const Color(0xFF48C6EF).withOpacity(0.4),
                              ),
                              child: const Text(
                                'Crear Cuenta',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '¿Ya tienes cuenta? ',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Text(
                                  'Inicia Sesión',
                                  style: TextStyle(
                                    color: Color(0xFF6C63FF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
