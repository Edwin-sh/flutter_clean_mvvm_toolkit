import 'package:flutter_clean_mvvm_toolkit/src/utils/validators/validators.dart';

/// Clase de utilidad para validaciones comunes de formularios que retornan [String?].
///
/// Ideal para usar directamente en la propiedad `validator` de los widgets de Flutter.
class FormValidators {
  /// Valida que un campo no esté vacío o sea nulo.
  static String? validateNoEmpty(String? value, String fieldName) {
    return Validators.validateNotEmpty(value, fieldName: fieldName)?.message;
  }

  /// Valida que un campo tenga un formato de email válido.
  static String? validateEmail(String? value) {
    return Validators.validateEmail(value)?.message;
  }

  /// Valida que un campo tenga una longitud mínima.
  static String? validateMinLength(
    String? value,
    int minLength,
    String fieldName,
  ) {
    return Validators.validateMinLength(
      value,
      minLength,
      fieldName: fieldName,
    )?.message;
  }

  /// Valida que un campo sea numérico.
  static String? validateIsNumeric(String? value, String fieldName) {
    return Validators.validateNumeric(value, fieldName: fieldName)?.message;
  }

  /// Valida que dos campos coincidan (ej: confirmar contraseña).
  static String? validateMatch(Object? value, Object? other, String message) {
    return Validators.validateMatch(value, other, message: message)?.message;
  }

  /// Valida un número de teléfono.
  static String? validatePhone(String? value, String fieldName) {
    return Validators.validatePhone(value, fieldName: fieldName)?.message;
  }

  /// Valida una URL.
  static String? validateUrl(String? value, String fieldName) {
    return Validators.validateUrl(value, fieldName: fieldName)?.message;
  }

  /// Valida la fortaleza de una contraseña.
  static String? validatePasswordStrength(String? value, String fieldName) {
    return Validators.validatePasswordStrength(
      value,
      fieldName: fieldName,
    )?.message;
  }
}
