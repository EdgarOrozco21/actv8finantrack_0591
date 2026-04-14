// Modelo de datos para Ingreso
class Ingreso {
  final int id;
  double monto;
  String fuente;
  DateTime fecha;

  Ingreso({
    required this.id,
    required this.monto,
    required this.fuente,
    required this.fecha,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'monto': monto,
      'fuente': fuente,
      'fecha': fecha.toIso8601String(),
    };
  }
}
