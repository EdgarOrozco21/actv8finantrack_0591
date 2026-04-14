import '../datos/diccionario_gastos.dart';
import '../datos/diccionario_ingresos.dart';

// Agente para eliminar datos de gastos e ingresos

bool eliminarGasto(int id) {
  if (datosGastos.containsKey(id)) {
    datosGastos.remove(id);
    return true;
  }
  return false;
}

bool eliminarIngreso(int id) {
  if (datosIngresos.containsKey(id)) {
    datosIngresos.remove(id);
    return true;
  }
  return false;
}
