import 'package:flutter/material.dart';

/// Mixin class que provee funcionalidad básica para formularios
///
/// Proporciona:
/// - Gestión de FormState global
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
}
