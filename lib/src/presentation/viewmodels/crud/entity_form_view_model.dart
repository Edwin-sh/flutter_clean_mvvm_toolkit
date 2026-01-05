import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm_toolkit/src/core/domain/entities/entity.dart';
import 'package:flutter_clean_mvvm_toolkit/src/presentation/enums/form_type.dart';
import 'package:flutter_clean_mvvm_toolkit/src/presentation/viewmodels/base/default_form_view_model.dart';

/// ViewModel abstracto para formularios de entidades.
///
/// **Responsabilidades:**
/// - Gestión de campos del formulario (controllers)
/// - Transformación bidireccional entre Entity y campos del formulario
/// - Limpieza de campos
/// - Gestión del estado del formulario (create/edit)
///
/// **NO es responsable de:**
/// - Operaciones CRUD (Create, Read, Update, Delete)
/// - Comunicación con Use Cases
/// - Lógica de negocio
///
/// Tipo genérico:
/// - [T]: Tipo de entidad del dominio que maneja el formulario
///
/// Ejemplo de uso:
/// ```dart
/// class PatientFormViewModel extends EntityFormViewModel<Patient> {
///   final TextEditingController nameController = TextEditingController();
///
///   PatientFormViewModel() {
///     createFormState();
///   }
///
///   @override
///   void loadDataFromEntity(Patient entity) {
///     nameController.text = entity.name;
///     formType = FormType.edit;
///   }
///
///   @override
///   Patient buildEntityFromForm() {
///     return Patient(name: nameController.text);
///   }
///
///   @override
///   void clearFormData() {
///     nameController.clear();
///     formType = FormType.create;
///   }
///
///   @override
///   void dispose() {
///     nameController.dispose();
///     super.dispose();
///   }
/// }
/// ```
abstract class EntityFormViewModel<T extends Entity>
    extends DefaultFormViewModel
    with ChangeNotifier {
  EntityFormViewModel();

  BuildContext? _context;

  /// Obtiene el contexto actual de Flutter
  BuildContext? get context => _context;

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

  /// Carga datos desde una entidad hacia los campos del formulario.
  ///
  /// Toma la entidad y popula los controllers/campos del formulario
  /// para mostrarla al usuario (útil en modo edición).
  ///
  /// [entity]: La entidad a cargar en el formulario
  void loadDataFromEntity(T entity);

  /// Construye una entidad a partir de los datos del formulario.
  ///
  /// **Importante:** Este método valida el formulario antes de crear la entidad.
  /// Si la validación falla, retorna null.
  ///
  /// Toma los valores de los controllers/campos del formulario
  /// y crea una instancia de la entidad solo si todos los campos son válidos.
  ///
  /// Returns: Nueva instancia de [T] con los datos del formulario, o null si la validación falla
  T? mapDataToEntity() {
    // Validar el formulario antes de crear la entidad
    if (formState?.currentState?.validate() ?? false) {
      return buildEntityFromForm();
    }
    return null;
  }

  /// Construye la entidad desde los campos del formulario.
  ///
  /// Este método se llama internamente después de que la validación sea exitosa.
  /// Debe implementarse para crear la entidad con los datos de los controllers.
  ///
  /// Returns: Nueva instancia de [T] con los datos del formulario
  T buildEntityFromForm();

  /// Limpia todos los campos del formulario.
  ///
  /// Debe limpiar controllers, resetear valores, etc.
  /// Útil cuando se cancela un formulario o después de guardar.
  void clearFormData();
}
