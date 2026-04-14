import 'package:flutter/material.dart';
import '../datos/datos_usuario.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Avatar
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF48C6EF)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  (usuarioActualNombre ?? 'U')[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              usuarioActualNombre ?? 'Usuario',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              usuarioActualEmail ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 40),

            // Opciones
            _buildMenuItem(
              context,
              icon: Icons.attach_money,
              title: 'Presupuesto Mensual',
              subtitle: 'Configura tu límite de gastos',
              color: const Color(0xFFFFBE0B),
              onTap: () {
                Navigator.pushNamed(context, '/presupuesto');
              },
            ),
            const SizedBox(height: 12),

            _buildMenuItem(
              context,
              icon: Icons.lock_outline,
              title: 'Cambiar Contraseña',
              subtitle: 'Actualiza tu contraseña',
              color: const Color(0xFF6C63FF),
              onTap: () {
                Navigator.pushNamed(context, '/cambiar_contrasena');
              },
            ),
            const SizedBox(height: 12),

            _buildMenuItem(
              context,
              icon: Icons.receipt_long,
              title: 'Lista de Gastos',
              subtitle: 'Ver todos los gastos',
              color: const Color(0xFFEF5350),
              onTap: () {
                Navigator.pushNamed(context, '/lista_gastos');
              },
            ),
            const SizedBox(height: 12),

            _buildMenuItem(
              context,
              icon: Icons.account_balance,
              title: 'Lista de Ingresos',
              subtitle: 'Ver todos los ingresos',
              color: const Color(0xFF00C853),
              onTap: () {
                Navigator.pushNamed(context, '/lista_ingresos');
              },
            ),
            const SizedBox(height: 32),

            // Cerrar sesión
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: const Color(0xFF1A1A40),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: const Text(
                        '¿Cerrar sesión?',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      content: const Text(
                        '¿Estás seguro de que deseas salir?',
                        style: TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Cancelar', style: TextStyle(color: Colors.white60)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            cerrarSesion();
                            Navigator.pop(ctx);
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEF5350),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFEF5350), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Color(0xFFEF5350)),
                    SizedBox(width: 10),
                    Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                        color: Color(0xFFEF5350),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.3)),
          ],
        ),
      ),
    );
  }
}
