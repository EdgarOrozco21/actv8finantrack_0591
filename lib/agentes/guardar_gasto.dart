import '../modelos/gasto.dart';
import '../datos/diccionario_gastos.dart';

// Agente para guardar gastos en el diccionario
Gasto guardarGasto({
  required double monto,
  required String categoria,
  required String descripcion,
  required DateTime fecha,
}) {
  final id = obtenerSiguienteIdGasto();
  final gasto = Gasto(
    id: id,
    monto: monto,
    categoria: categoria,
    descripcion: descripcion,
    fecha: fecha,
  );
  datosGastos[id] = gasto;
  return gasto;
}
