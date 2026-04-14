import '../modelos/ingreso.dart';

// Diccionario de ingresos – almacenamiento en memoria
Map<int, Ingreso> datosIngresos = {};

// ID autoincrementable para ingresos
int _siguienteIdIngreso = 1;

int obtenerSiguienteIdIngreso() {
  return _siguienteIdIngreso++;
}

// Obtener todos los ingresos como lista
List<Ingreso> obtenerTodosLosIngresos() {
  return datosIngresos.values.toList();
}

// Obtener ingresos del mes actual
List<Ingreso> obtenerIngresosDelMes(int anio, int mes) {
  return datosIngresos.values
      .where((i) => i.fecha.year == anio && i.fecha.month == mes)
      .toList();
}

// Obtener total de ingresos del mes
double obtenerTotalIngresosMes(int anio, int mes) {
  return obtenerIngresosDelMes(anio, mes).fold(0.0, (sum, i) => sum + i.monto);
}
