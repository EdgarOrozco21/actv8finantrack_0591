import 'package:flutter/material.dart';
import '../modelos/ingreso.dart';
import '../agentes/actualizar_datos.dart';
import '../agentes/eliminar_datos.dart';

class DetalleIngresoScreen extends StatefulWidget {
  const DetalleIngresoScreen({super.key});

  @override
  State<DetalleIngresoScreen> createState() => _DetalleIngresoScreenState();
}

class _DetalleIngresoScreenState extends State<DetalleIngresoScreen> {
  late TextEditingController _montoController;
  late TextEditingController _fuenteController;
  late DateTime _fechaSeleccionada;
  late Ingreso _ingreso;
  bool _editando = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _ingreso = ModalRoute.of(context)!.settings.arguments as Ingreso;
    _montoController = TextEditingController(text: _ingreso.monto.toStringAsFixed(2));
    _fuenteController = TextEditingController(text: _ingreso.fuente);
    _fechaSeleccionada = _ingreso.fecha;
  }

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

  void _guardarCambios() {
    if (_formKey.currentState!.validate()) {
      actualizarIngreso(
        id: _ingreso.id,
        monto: double.parse(_montoController.text),
        fuente: _fuenteController.text.trim(),
        fecha: _fechaSeleccionada,
      );

      setState(() {
        _editando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('¡Ingreso actualizado exitosamente!'),
            ],
          ),
          backgroundColor: const Color(0xFF00C853),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  void _eliminar() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          '¿Eliminar ingreso?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Esta acción no se puede deshacer.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar', style: TextStyle(color: Colors.white60)),
          ),
          ElevatedButton(
            onPressed: () {
              eliminarIngreso(_ingreso.id);
              Navigator.pop(ctx);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(Icons.delete, color: Colors.white),
                      SizedBox(width: 12),
                      Text('Ingreso eliminado'),
                    ],
                  ),
                  backgroundColor: const Color(0xFFEF5350),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF5350),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Eliminar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _montoController.dispose();
    _fuenteController.dispose();
    super.dispose();
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    const Text(
                      'Detalle del Ingreso',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _editando = !_editando;
                            });
                          },
                          icon: Icon(
                            _editando ? Icons.close : Icons.edit,
                            color: const Color(0xFF00C853),
                          ),
                        ),
                        IconButton(
                          onPressed: _eliminar,
                          icon: const Icon(Icons.delete, color: Color(0xFFEF5350)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ID Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00C853).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'ID: ${_ingreso.id}',
                            style: const TextStyle(
                              color: Color(0xFF00C853),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Monto
                        const Text('Monto', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _montoController,
                          enabled: _editando,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            prefixStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 28, fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Color(0xFF00C853), width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Ingresa el monto';
                            if (double.tryParse(value) == null || double.parse(value) <= 0) return 'Monto inválido';
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        // Fuente
                        const Text('Fuente', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _fuenteController,
                          enabled: _editando,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Color(0xFF00C853), width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Ingresa la fuente';
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        // Fecha
                        const Text('Fecha', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: _editando ? _seleccionarFecha : null,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white.withOpacity(_editando ? 0.15 : 0.08)),
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

                        if (_editando)
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _guardarCambios,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00C853),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                elevation: 8,
                                shadowColor: const Color(0xFF00C853).withOpacity(0.4),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.save, size: 22),
                                  SizedBox(width: 10),
                                  Text('Guardar Cambios', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
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
