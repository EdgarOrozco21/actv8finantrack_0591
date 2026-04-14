// Datos del usuario en memoria para autenticación y perfil

// Almacén de usuarios registrados {email: {nombre, contrasena}}
Map<String, Map<String, String>> usuariosRegistrados = {};

// Usuario actualmente logueado
String? usuarioActualEmail;
String? usuarioActualNombre;

// Presupuesto mensual
double presupuestoMensual = 0.0;

// Registrar un nuevo usuario
bool registrarUsuario(String nombre, String email, String contrasena) {
  if (usuariosRegistrados.containsKey(email)) {
    return false; // Ya existe
  }
  usuariosRegistrados[email] = {
    'nombre': nombre,
    'contrasena': contrasena,
  };
  return true;
}

// Iniciar sesión
bool iniciarSesion(String email, String contrasena) {
  final usuario = usuariosRegistrados[email];
  if (usuario != null && usuario['contrasena'] == contrasena) {
    usuarioActualEmail = email;
    usuarioActualNombre = usuario['nombre'];
    return true;
  }
  return false;
}

// Cerrar sesión
void cerrarSesion() {
  usuarioActualEmail = null;
  usuarioActualNombre = null;
}

// Cambiar contraseña
bool cambiarContrasena(String email, String contrasenaActual, String nuevaContrasena) {
  final usuario = usuariosRegistrados[email];
  if (usuario != null && usuario['contrasena'] == contrasenaActual) {
    usuario['contrasena'] = nuevaContrasena;
    return true;
  }
  return false;
}
