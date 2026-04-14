import 'package:flutter/material.dart';
import '../agentes/guardar_ingreso.dart';
import '../datos/diccionario_ingresos.dart';

class CapturaIngresoScreen extends StatefulWidget {
  const CapturaIngresoScreen({super.key});

  @override
  State<CapturaIngresoScreen> createState() => _CapturaIngresoScreenState();
}

class _CapturaIngresoScreenState extends State<CapturaIngresoScreen> {
  final _montoController = TextEditingController();
  final _fuenteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime _fechaSeleccionada = DateTime.now();
  String _fuenteSeleccionada = '';

  final List<Map<String, dynamic>> _fuentes = [
    {'nombre': 'Salario', 'icono': Icons.work, 'color': const Color(0xFF00C853)},
    {'nombre': 'Freelance', 'icono': Icons.laptop, 'color': const Color(0xFF48C6EF)},
    {'nombre': 'Inversiones', 'icono': Icons.trending_up, 'color': const Color(0xFFFFBE0B)},
    {'nombre': 'Ventas', 'icono': Icons.store, 'color': const Color(0xFFFB5607)},
    {'nombre': 'Regalo', 'icono': Icons.card_giftcard, 'color': const Color(0xFF8338EC)},
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
              primary: Color(0xFF00C853),
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
      final fuente = _fuenteSeleccionada.isNotEmpty
          ? _fuenteSeleccionada
          : _fuenteController.text.trim();

      if (fuente.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.white),
                SizedBox(width: 12),
                Text('Selecciona o escribe una fuente'),
              ],
            ),
            backgroundColor: const Color(0xFFFFB74D),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        return;
      }

      guardarIngreso(
        monto: double.parse(_montoController.text),
        fuente: fuente,
        fecha: _fechaSeleccionada,
      );

      _montoController.clear();
      _fuenteController.clear();
      setState(() {
        _fuenteSeleccionada = '';
        _fechaSeleccionada = DateTime.now();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('¡Ingreso registrado exitosamente!'),
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
    _fuenteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ingresosRecientes = obtenerTodosLosIngresos();
    ingresosRecientes.sort((a, b) => b.fecha.compareTo(a.fecha));

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Registrar Ingreso',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Ingresa los detalles de tu ingreso',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 28),

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Monto
                  const Text(
                    'Monto',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
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
                        borderSide: const BorderSide(color: Color(0xFF00C853), width: 2),
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
                      if (value == null || value.isEmpty) return 'Ingresa el monto';
                      if (double.tryParse(value) == null || double.parse(value) <= 0) return 'Ingresa un monto válido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Fuente
                  const Text(
                    'Fuente de Ingreso',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _fuentes.map((f) {
                      final seleccionada = _fuenteSeleccionada == f['nombre'];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _fuenteSeleccionada = f['nombre'] as String;
                            _fuenteController.clear();
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: seleccionada
                                ? (f['color'] as Color).withOpacity(0.2)
                                : Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: seleccionada ? f['color'] as Color : Colors.white.withOpacity(0.1),
                              width: seleccionada ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(f['icono'] as IconData, size: 18, color: f['color'] as Color),
                              const SizedBox(width: 6),
                              Text(
                                f['nombre'] as String,
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
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _fuenteController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'O escribe otra fuente...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFF00C853), width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _fuenteSeleccionada = '';
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),

                  // Fecha
                  const Text(
                    'Fecha',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
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
                            style: const TextStyle(color: Colors.white, fontSize: 16),
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
                        backgroundColor: const Color(0xFF00C853),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                        shadowColor: const Color(0xFF00C853).withOpacity(0.4),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save, size: 22),
                          SizedBox(width: 10),
                          Text(
                            'Guardar Ingreso',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Lista de ingresos recientes
            if (ingresosRecientes.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Historial de Ingresos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/lista_ingresos').then((_) {
                        setState(() {});
                      });
                    },
                    child: const Text(
                      'Ver todos',
                      style: TextStyle(color: Color(0xFF48C6EF)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...ingresosRecientes.take(3).map((ingreso) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/detalle_ingreso', arguments: ingreso).then((_) {
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
                            color: const Color(0xFF00C853).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.arrow_downward, color: Color(0xFF00C853), size: 18),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ingreso.fuente,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              Text(
                                '${ingreso.fecha.day}/${ingreso.fecha.month}/${ingreso.fecha.year}',
                                style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '+\$${ingreso.monto.toStringAsFixed(2)}',
                          style: const TextStyle(color: Color(0xFF00C853), fontWeight: FontWeight.bold, fontSize: 14),
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
