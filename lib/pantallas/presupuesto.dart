import 'package:flutter/material.dart';
import '../datos/datos_usuario.dart';

class PresupuestoScreen extends StatefulWidget {
  const PresupuestoScreen({super.key});

  @override
  State<PresupuestoScreen> createState() => _PresupuestoScreenState();
}

class _PresupuestoScreenState extends State<PresupuestoScreen> {
  final _presupuestoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (presupuestoMensual > 0) {
      _presupuestoController.text = presupuestoMensual.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _presupuestoController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        presupuestoMensual = double.parse(_presupuestoController.text);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('¡Presupuesto actualizado!'),
            ],
          ),
          backgroundColor: const Color(0xFF00C853),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );

      Navigator.pop(context);
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
                      'Presupuesto Mensual',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icono
                      Center(
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFBE0B), Color(0xFFFB5607)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFBE0B).withOpacity(0.3),
                                blurRadius: 25,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.savings,
                            size: 44,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      Center(
                        child: Text(
                          'Define tu límite de gastos mensual',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Te alertaremos cuando estés cerca del límite',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Presupuesto actual
                      if (presupuestoMensual > 0)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFBE0B).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: const Color(0xFFFFBE0B).withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline, color: Color(0xFFFFBE0B)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Presupuesto actual: \$${presupuestoMensual.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Color(0xFFFFBE0B),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Nuevo Presupuesto',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _presupuestoController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                prefixText: '\$ ',
                                prefixStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 28, fontWeight: FontWeight.bold),
                                hintText: '0.00',
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 28),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(color: Color(0xFFFFBE0B), width: 2),
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
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Ingresa un monto';
                                if (double.tryParse(value) == null || double.parse(value) <= 0) return 'Ingresa un monto válido';
                                return null;
                              },
                            ),
                            const SizedBox(height: 32),

                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: _guardar,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFBE0B),
                                  foregroundColor: Colors.black87,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  elevation: 8,
                                  shadowColor: const Color(0xFFFFBE0B).withOpacity(0.4),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.save, size: 22),
                                    SizedBox(width: 10),
                                    Text(
                                      'Guardar Presupuesto',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    ),
                                  ],
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
