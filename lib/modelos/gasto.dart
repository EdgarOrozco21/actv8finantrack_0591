// Modelo de datos para Gasto
class Gasto {
  final int id;
  double monto;
  String categoria;
  String descripcion;
  DateTime fecha;

  Gasto({
    required this.id,
    required this.monto,
    required this.categoria,
    required this.descripcion,
    required this.fecha,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'monto': monto,
      'categoria': categoria,
      'descripcion': descripcion,
      'fecha': fecha.toIso8601String(),
    };
  }
}
