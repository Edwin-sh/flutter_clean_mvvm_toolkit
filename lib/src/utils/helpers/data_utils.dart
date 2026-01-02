/// Clase de utilidades para manejar conversiones de tipos dinámicos.
///
/// Proporciona métodos seguros para extraer datos de mapas dinámicos,
/// especialmente útil al deserializar datos de JSON o similares.
///
/// Todos los métodos son null-safe y retornan valores por defecto
/// en caso de tipos incorrectos o valores nulos.
class DataUtils {
  DataUtils._();

  /// Extrae un String de un valor dinámico, retornando una cadena vacía si es null.
  ///
  /// [value]: Valor dinámico que se espera sea un String.
  /// Returns: String extraído o cadena vacía si el valor es null o no es String.
  static String getStringFromDynamic(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  /// Convierte un valor dinámico a un Map<String, dynamic>.
  ///
  /// [value]: Valor dinámico que se espera sea un Map.
  /// Returns: Map<String, dynamic> extraído o mapa vacío si el valor es null o no es Map.
  static Map<String, dynamic> mapFromDynamic(dynamic value) {
    if (value == null) return <String, dynamic>{};
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map<String, dynamic>(
        (key, val) => MapEntry<String, dynamic>(key.toString(), val),
      );
    }
    return <String, dynamic>{};
  }

  /// Extrae un int de un valor dinámico, retornando 0 si es null.
  ///
  /// [value]: Valor dinámico que se espera sea un int.
  /// Returns: int extraído o 0 si el valor es null o no se puede convertir.
  static int getIntFromDynamic(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  /// Extrae un double de un valor dinámico, retornando 0.0 si es null.
  ///
  /// [value]: Valor dinámico que se espera sea un double.
  /// Returns: double extraído o 0.0 si el valor es null o no se puede convertir.
  static double getDoubleFromDynamic(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  /// Extrae un bool de un valor dinámico, retornando false si es null.
  ///
  /// [value]: Valor dinámico que se espera sea un bool.
  /// Returns: bool extraído o false si el valor es null o no se puede convertir.
  static bool getBoolFromDynamic(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is String) {
      final lowercaseValue = value.toLowerCase();
      return lowercaseValue == 'true' || lowercaseValue == '1';
    }
    if (value is int) return value != 0;
    return false;
  }

  /// Extrae una List de un valor dinámico, retornando lista vacía si es null.
  ///
  /// [value]: Valor dinámico que se espera sea una List.
  /// Returns: List<T> extraída o lista vacía si el valor es null o no es List.
  static List<T> getListFromDynamic<T>(dynamic value) {
    if (value == null) return <T>[];
    if (value is List<T>) return value;
    if (value is List) {
      try {
        return value.cast<T>();
      } catch (e) {
        return <T>[];
      }
    }
    return <T>[];
  }
}
