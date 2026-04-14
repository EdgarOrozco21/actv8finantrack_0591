import '../modelos/gasto.dart';

// Diccionario de gastos – almacenamiento en memoria
Map<int, Gasto> datosGastos = {};

// ID autoincrementable para gastos
int _siguienteIdGasto = 1;

int obtenerSiguienteIdGasto() {
  return _siguienteIdGasto++;
}

// Obtener todos los gastos como lista
List<Gasto> obtenerTodosLosGastos() {
  return datosGastos.values.toList();
}

// Obtener gastos del mes actual
List<Gasto> obtenerGastosDelMes(int anio, int mes) {
  return datosGastos.values
      .where((g) => g.fecha.year == anio && g.fecha.month == mes)
      .toList();
}

// Obtener total de gastos del mes
double obtenerTotalGastosMes(int anio, int mes) {
  return obtenerGastosDelMes(anio, mes).fold(0.0, (sum, g) => sum + g.monto);
}
