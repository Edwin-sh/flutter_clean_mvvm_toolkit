/// Enum que define los tipos de operación de formularios
///
/// Usado para determinar el comportamiento de los formularios CRUD:
/// - [create]: Formulario para crear nueva entidad
/// - [read]: Formulario en modo solo lectura
/// - [update]: Formulario para editar entidad existente
enum FormType {
  /// Modo de creación de nueva entidad
  create,

  /// Modo de edición de entidad existente
  update,
}
