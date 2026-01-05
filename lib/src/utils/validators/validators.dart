import 'package:flutter_clean_mvvm_toolkit/src/core/errors/error_item.dart';
import 'package:flutter_clean_mvvm_toolkit/src/core/errors/error_level_enum.dart';
import 'package:flutter_clean_mvvm_toolkit/src/data/models/model.dart';

/// Clase de utilidad para validaciones avanzadas que retornan [ErrorItem].
///
/// Estas validaciones son ideales para la capa de Dominio y ViewModels,
/// ya que proporcionan un error estructurado con niveles de severidad.
class Validators {
  /// Evalúa que ningún campo de un [Model] sea nulo.
  static ErrorItem? validateModelNotNull<T extends Model>(
    T model, {
    String message = 'Datos del modelo incompletos',
  }) {
    if (model.toJson().values.any((v) => v == null)) {
      return ErrorItem.validation(
        message: message,
        errorLevel: ErrorLevelEnum.severe,
      );
    }
    return null;
  }

  /// Evalúa que un objeto no sea nulo.
  static ErrorItem? validateNotNull(
    Object? value, {
    String fieldName = 'Este campo',
  }) {
    if (value == null) {
      return ErrorItem.validation(message: '$fieldName es requerido');
    }
    return null;
  }

  /// Evalúa que un string no sea nulo ni esté vacío.
  static ErrorItem? validateNotEmpty(
    String? value, {
    String fieldName = 'Este campo',
  }) {
    if (value == null || value.trim().isEmpty) {
      return ErrorItem.validation(message: '$fieldName no puede estar vacío');
    }
    return null;
  }

  /// Evalúa que el valor tenga una longitud mínima.
  static ErrorItem? validateMinLength(
    String? value,
    int minLength, {
    String fieldName = 'Este campo',
  }) {
    if (value == null || value.length < minLength) {
      return ErrorItem.validation(
        message: '$fieldName debe tener al menos $minLength caracteres',
      );
    }
    return null;
  }

  /// Evalúa que el valor tenga una longitud máxima.
  static ErrorItem? validateMaxLength(
    String? value,
    int maxLength, {
    String fieldName = 'Este campo',
  }) {
    if (value != null && value.length > maxLength) {
      return ErrorItem.validation(
        message: '$fieldName no puede tener más de $maxLength caracteres',
      );
    }
    return null;
  }

  /// Evalúa que el valor sea un correo electrónico válido.
  static ErrorItem? validateEmail(
    String? value, {
    String fieldName = 'El correo electrónico',
  }) {
    final emptyCheck = validateNotEmpty(value, fieldName: fieldName);
    if (emptyCheck != null) return emptyCheck;

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value!)) {
      return ErrorItem.validation(
        message: '$fieldName no es un correo electrónico válido',
      );
    }
    return null;
  }

  /// Evalúa que un valor numérico esté dentro de un rango específico.
  static ErrorItem? validateRange(
    num? value,
    num min,
    num max, {
    String fieldName = 'Este campo',
  }) {
    if (value == null || value < min || value > max) {
      return ErrorItem.validation(
        message: '$fieldName debe estar entre $min y $max',
      );
    }
    return null;
  }

  /// Evalúa que un string tenga un rango de longitud específico.
  static ErrorItem? validateStringLengthRange(
    String? value,
    int minLength,
    int maxLength, {
    String fieldName = 'Este campo',
  }) {
    final emptyCheck = validateNotEmpty(value, fieldName: fieldName);
    if (emptyCheck != null) return emptyCheck;

    if (value!.length < minLength || value.length > maxLength) {
      return ErrorItem.validation(
        message:
            '$fieldName debe tener entre $minLength y $maxLength caracteres',
      );
    }
    return null;
  }

  /// Evalúa que un string contenga solo letras y espacios.
  static ErrorItem? validateAlphabetic(
    String? value, {
    String fieldName = 'Este campo',
  }) {
    final emptyCheck = validateNotEmpty(value, fieldName: fieldName);
    if (emptyCheck != null) return emptyCheck;

    final alphabeticRegex = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');
    if (!alphabeticRegex.hasMatch(value!)) {
      return ErrorItem.validation(
        message: '$fieldName debe contener solo letras y espacios',
      );
    }
    return null;
  }

  /// Evalúa que un valor sea numérico.
  static ErrorItem? validateNumeric(
    String? value, {
    String fieldName = 'Este campo',
  }) {
    final emptyCheck = validateNotEmpty(value, fieldName: fieldName);
    if (emptyCheck != null) return emptyCheck;

    final numericRegex = RegExp(r'^-?[0-9]+(\.[0-9]+)?$');
    if (!numericRegex.hasMatch(value!)) {
      return ErrorItem.validation(
        message: '$fieldName debe ser un número válido',
      );
    }
    return null;
  }

  /// Evalúa que una fecha no sea futura.
  static ErrorItem? validateNotFutureDate(
    DateTime? date, {
    String fieldName = 'La fecha',
  }) {
    if (date == null) {
      return ErrorItem.validation(message: '$fieldName es requerido');
    }
    if (date.isAfter(DateTime.now())) {
      return ErrorItem.validation(
        message: '$fieldName no puede ser una fecha futura',
      );
    }
    return null;
  }

  /// Evalúa que dos valores coincidan (ej: confirmar contraseña).
  static ErrorItem? validateMatch(
    Object? value,
    Object? other, {
    String message = 'Los campos no coinciden',
  }) {
    if (value != other) {
      return ErrorItem.validation(message: message);
    }
    return null;
  }

  /// Evalúa que un string sea un número de teléfono válido.
  static ErrorItem? validatePhone(
    String? value, {
    String fieldName = 'El teléfono',
  }) {
    final emptyCheck = validateNotEmpty(value, fieldName: fieldName);
    if (emptyCheck != null) return emptyCheck;

    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegex.hasMatch(value!)) {
      return ErrorItem.validation(message: '$fieldName no es un número válido');
    }
    return null;
  }

  /// Evalúa que un string sea una URL válida.
  static ErrorItem? validateUrl(String? value, {String fieldName = 'La URL'}) {
    final emptyCheck = validateNotEmpty(value, fieldName: fieldName);
    if (emptyCheck != null) return emptyCheck;

    final urlRegex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    );
    if (!urlRegex.hasMatch(value!)) {
      return ErrorItem.validation(
        message: '$fieldName no es una dirección válida',
      );
    }
    return null;
  }

  /// Evalúa la fortaleza de una contraseña.
  static ErrorItem? validatePasswordStrength(
    String? value, {
    String fieldName = 'La contraseña',
  }) {
    final emptyCheck = validateNotEmpty(value, fieldName: fieldName);
    if (emptyCheck != null) return emptyCheck;

    if (value!.length < 8) {
      return ErrorItem.validation(
        message: '$fieldName debe tener al menos 8 caracteres',
      );
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return ErrorItem.validation(
        message: '$fieldName debe incluir al menos una mayúscula',
      );
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return ErrorItem.validation(
        message: '$fieldName debe incluir al menos un número',
      );
    }
    return null;
  }
}
