import 'package:flutter/material.dart';
import '../datos/diccionario_gastos.dart';
import '../modelos/gasto.dart';

class ListaGastosScreen extends StatefulWidget {
  const ListaGastosScreen({super.key});

  @override
  State<ListaGastosScreen> createState() => _ListaGastosScreenState();
}

class _ListaGastosScreenState extends State<ListaGastosScreen> {
  final iconos = {
    'Alimentación': Icons.restaurant,
    'Transporte': Icons.directions_car,
    'Entretenimiento': Icons.movie,
    'Salud': Icons.local_hospital,
    'Educación': Icons.school,
    'Hogar': Icons.home,
    'Ropa': Icons.checkroom,
    'Servicios': Icons.build,
    'Otro': Icons.more_horiz,
  };

  @override
  Widget build(BuildContext context) {
    final gastos = obtenerTodosLosGastos();
    gastos.sort((a, b) => b.fecha.compareTo(a.fecha));

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
                      'Todos los Gastos',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF5350).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${gastos.length} registros',
                        style: const TextStyle(
                          color: Color(0xFFEF5350),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: gastos.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.receipt_long, size: 64, color: Colors.white.withOpacity(0.2)),
                            const SizedBox(height: 16),
                            Text(
                              'No hay gastos registrados',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: gastos.length,
                        itemBuilder: (context, index) {
                          final gasto = gastos[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/detalle_gasto', arguments: gasto).then((_) {
                                setState(() {});
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.07),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white.withOpacity(0.08)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEF5350).withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      iconos[gasto.categoria] ?? Icons.money_off,
                                      color: const Color(0xFFEF5350),
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          gasto.categoria,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          gasto.descripcion,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white.withOpacity(0.5),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '-\$${gasto.monto.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFEF5350),
                                        ),
                                      ),
                                      Text(
                                        '${gasto.fecha.day}/${gasto.fecha.month}/${gasto.fecha.year}',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white.withOpacity(0.4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
