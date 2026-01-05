/// Clase base para todos los modelos de datos.
///
/// Los modelos son representaciones de datos (Data Transfer Objects)
/// que pueden ser serializados y deserializados.
abstract class Model {
  const Model();

  /// Convierte el modelo a un mapa JSON.
  Map<String, dynamic> toJson();
}
