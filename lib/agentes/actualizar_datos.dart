import '../datos/diccionario_gastos.dart';
import '../datos/diccionario_ingresos.dart';

// Agente para actualizar datos de gastos e ingresos

bool actualizarGasto({
  required int id,
  double? monto,
  String? categoria,
  String? descripcion,
  DateTime? fecha,
}) {
  final gasto = datosGastos[id];
  if (gasto == null) return false;

  if (monto != null) gasto.monto = monto;
  if (categoria != null) gasto.categoria = categoria;
  if (descripcion != null) gasto.descripcion = descripcion;
  if (fecha != null) gasto.fecha = fecha;

  return true;
}

bool actualizarIngreso({
  required int id,
  double? monto,
  String? fuente,
  DateTime? fecha,
}) {
  final ingreso = datosIngresos[id];
  if (ingreso == null) return false;

  if (monto != null) ingreso.monto = monto;
  if (fuente != null) ingreso.fuente = fuente;
  if (fecha != null) ingreso.fecha = fecha;

  return true;
}
