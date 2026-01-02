import 'package:flutter/material.dart';

/// Mixin class que provee funcionalidad básica para formularios
///
/// Proporciona:
/// - Gestión de FormState global
/// - Validaciones comunes (campos requeridos)
///
/// Ejemplo de uso:
/// ```dart
/// class MyFormViewModel extends DefaultFormViewModel {
///   MyFormViewModel() {
///     createFormState();
///   }
/// }
/// ```
mixin class DefaultFormViewModel {
  DefaultFormViewModel();

  /// FormState global del formulario
  GlobalKey<FormState>? formState;

  /// Crea una nueva instancia de FormState
  ///
  /// Debe llamarse en el constructor del ViewModel
  void createFormState() {
    formState = GlobalKey<FormState>();
  }

  /// Valida que un campo no esté vacío
  ///
  /// [value]: Valor del campo a validar
  /// [messageError]: Mensaje descriptivo del campo (ej: "el nombre")
  ///
  /// Retorna mensaje de error si está vacío, null si es válido
  String? validateNoEmpty(String? value, String messageError) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese $messageError';
    }
    return null;
  }
}
