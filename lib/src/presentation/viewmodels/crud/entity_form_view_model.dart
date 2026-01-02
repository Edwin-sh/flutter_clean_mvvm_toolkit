import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm_toolkit/src/core/domain/entities/entity.dart';
import 'package:flutter_clean_mvvm_toolkit/src/presentation/enums/form_type.dart';
import 'package:flutter_clean_mvvm_toolkit/src/presentation/viewmodels/base/default_form_view_model.dart';

/// ViewModel abstracto para formularios de entidades
///
/// Provee gestión de estado para formularios CRUD con:
/// - Almacenamiento temporal de entidad
/// - Acceso al contexto de Flutter
/// - Notificaciones de cambios (ChangeNotifier)
/// - Funcionalidad básica de formularios (DefaultFormViewModel)
///
/// Tipo genérico:
/// - [T]: Tipo de entidad del dominio que maneja el formulario
///
/// Ejemplo de uso:
/// ```dart
/// class PatientFormViewModel extends EntityFormViewModel<Patient> {
///   @override
///   void loadDataFromEntity() {
///     final patient = getEntiTyData((data) => data);
///     if (patient != null) {
///       nameController.text = patient.name;
///     }
///   }
/// }
/// ```
abstract class EntityFormViewModel<T extends Entity> extends DefaultFormViewModel
    with ChangeNotifier {
  EntityFormViewModel();

  BuildContext? _context;

  /// Obtiene el contexto actual de Flutter
  BuildContext? get context => _context;


  /// Limpia todos los datos del formulario
  ///
  /// Por defecto solo limpia la entidad, pero puede ser sobrescrito
  /// para limpiar controllers, campos adicionales, etc.
  void clearFormData();

  /// Establece el contexto de Flutter
  ///
  /// [context]: BuildContext actual del widget
  void setContext(BuildContext context) {
    _context = context;
  }

    // Form type (create, edit)
  FormType _formType = FormType.create;
  FormType get formType => _formType;

  set formType(FormType type) {
    _formType = type;
    notifyListeners();
  }
}
