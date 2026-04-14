import 'package:flutter/material.dart';
import '../agentes/guardar_gasto.dart';
import '../datos/diccionario_gastos.dart';

class CapturaGastoScreen extends StatefulWidget {
  const CapturaGastoScreen({super.key});

  @override
  State<CapturaGastoScreen> createState() => _CapturaGastoScreenState();
}

class _CapturaGastoScreenState extends State<CapturaGastoScreen> {
  final _montoController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _categoriaSeleccionada = 'Alimentación';
  DateTime _fechaSeleccionada = DateTime.now();

  final List<Map<String, dynamic>> _categorias = [
    {'nombre': 'Alimentación', 'icono': Icons.restaurant, 'color': const Color(0xFFFF6B6B)},
    {'nombre': 'Transporte', 'icono': Icons.directions_car, 'color': const Color(0xFF4ECDC4)},
    {'nombre': 'Entretenimiento', 'icono': Icons.movie, 'color': const Color(0xFFFFBE0B)},
    {'nombre': 'Salud', 'icono': Icons.local_hospital, 'color': const Color(0xFFFF006E)},
    {'nombre': 'Educación', 'icono': Icons.school, 'color': const Color(0xFF8338EC)},
    {'nombre': 'Hogar', 'icono': Icons.home, 'color': const Color(0xFF3A86FF)},
    {'nombre': 'Ropa', 'icono': Icons.checkroom, 'color': const Color(0xFFFB5607)},
    {'nombre': 'Servicios', 'icono': Icons.build, 'color': const Color(0xFF06D6A0)},
    {'nombre': 'Otro', 'icono': Icons.more_horiz, 'color': const Color(0xFF9B9B9B)},
  ];

  Future<void> _seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6C63FF),
              surface: Color(0xFF1A1A40),
            ),
          ),
          child: child!,
        );
      },
    );
    if (fecha != null) {
      setState(() {
        _fechaSeleccionada = fecha;
      });
    }
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      guardarGasto(
        monto: double.parse(_montoController.text),
        categoria: _categoriaSeleccionada,
        descripcion: _descripcionController.text.trim(),
        fecha: _fechaSeleccionada,
      );

      _montoController.clear();
      _descripcionController.clear();
      setState(() {
        _categoriaSeleccionada = 'Alimentación';
        _fechaSeleccionada = DateTime.now();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('¡Gasto registrado exitosamente!'),
            ],
          ),
          backgroundColor: const Color(0xFF00C853),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _montoController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gastosRecientes = obtenerTodosLosGastos();
    gastosRecientes.sort((a, b) => b.fecha.compareTo(a.fecha));

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Registrar Gasto',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Ingresa los detalles de tu gasto',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 28),

            // Formulario
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Monto
                  const Text(
                    'Monto',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _montoController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      prefixText: '\$ ',
                      prefixStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 24, fontWeight: FontWeight.bold),
                      hintText: '0.00',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 24),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFEF5350), width: 2),
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
                      if (value == null || value.isEmpty) {
                        return 'Ingresa el monto';
                      }
                      if (double.tryParse(value) == null || double.parse(value) <= 0) {
                        return 'Ingresa un monto válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Categoría
                  const Text(
                    'Categoría',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _categorias.map((cat) {
                      final seleccionada = _categoriaSeleccionada == cat['nombre'];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _categoriaSeleccionada = cat['nombre'];
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: seleccionada
                                ? (cat['color'] as Color).withOpacity(0.2)
                                : Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: seleccionada
                                  ? cat['color'] as Color
                                  : Colors.white.withOpacity(0.1),
                              width: seleccionada ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(cat['icono'] as IconData, size: 18, color: cat['color'] as Color),
                              const SizedBox(width: 6),
                              Text(
                                cat['nombre'] as String,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: seleccionada ? Colors.white : Colors.white.withOpacity(0.6),
                                  fontWeight: seleccionada ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Descripción
                  const Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descripcionController,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Describe tu gasto...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresa una descripción';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Fecha
                  const Text(
                    'Fecha',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _seleccionarFecha,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.15)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.white.withOpacity(0.7), size: 20),
                          const SizedBox(width: 12),
                          Text(
                            '${_fechaSeleccionada.day}/${_fechaSeleccionada.month}/${_fechaSeleccionada.year}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Botón Guardar
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _guardar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF5350),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                        shadowColor: const Color(0xFFEF5350).withOpacity(0.4),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save, size: 22),
                          SizedBox(width: 10),
                          Text(
                            'Guardar Gasto',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Lista de gastos recientes
            if (gastosRecientes.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Historial de Gastos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/lista_gastos').then((_) {
                        setState(() {});
                      });
                    },
                    child: const Text(
                      'Ver todos',
                      style: TextStyle(color: Color(0xFF6C63FF)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...gastosRecientes.take(3).map((gasto) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/detalle_gasto', arguments: gasto).then((_) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF5350).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.arrow_upward, color: Color(0xFFEF5350), size: 18),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                gasto.categoria,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              Text(
                                gasto.descripcion,
                                style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '-\$${gasto.monto.toStringAsFixed(2)}',
                          style: const TextStyle(color: Color(0xFFEF5350), fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}
