import '../modelos/ingreso.dart';
import '../datos/diccionario_ingresos.dart';

// Agente para guardar ingresos en el diccionario
Ingreso guardarIngreso({
  required double monto,
  required String fuente,
  required DateTime fecha,
}) {
  final id = obtenerSiguienteIdIngreso();
  final ingreso = Ingreso(
    id: id,
    monto: monto,
    fuente: fuente,
    fecha: fecha,
  );
  datosIngresos[id] = ingreso;
  return ingreso;
}
