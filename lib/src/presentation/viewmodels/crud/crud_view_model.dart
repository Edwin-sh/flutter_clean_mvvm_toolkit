import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm_toolkit/src/core/domain/entities/entity.dart';

/// ViewModel para operaciones CRUD sobre entidades.
///
/// **Responsabilidades:**
/// - Ejecutar operaciones CRUD (Create, Read, Update, Delete, List)
/// - Comunicarse con Use Cases del dominio
/// - Gestionar el estado de la lista de entidades
///
/// **NO es responsable de:**
/// - Gestión de campos del formulario (eso es de EntityFormViewModel)
/// - Validaciones de UI (eso es de FormValidators)
/// - Coordinación entre ViewModels (eso es del Widget)
///
/// Tipo genérico:
/// - [T]: Tipo de entidad del dominio
///
/// Ejemplo de implementación:
/// ```dart
/// class PatientCrudViewModel with ChangeNotifier {
///   final CreatePatientUseCase _createUseCase;
///   final GetPatientUseCase _getUseCase;
///   final UpdatePatientUseCase _updateUseCase;
///   final DeletePatientUseCase _deleteUseCase;
///   final GetPatientsUseCase _getPatientsUseCase;
///
///   List<Patient> _patients = [];
///   List<Patient> get patients => _patients;
///
///   Future<bool> addEntity(Patient patient) async {
///     final result = await _createUseCase.call(patient);
///     return result.fold(
///       (error) {
///         // Manejar error
///         return false;
///       },
///       (success) {
///         getEntities(); // Recargar lista
///         return true;
///       },
///     );
///   }
///
///   Future<Patient?> getEntity(String id) async {
///     final result = await _getUseCase.call(id);
///     return result.fold(
///       (error) => null,
///       (patient) => patient,
///     );
///   }
///
///   Future<bool> updateEntity(Patient patient) async {
///     final result = await _updateUseCase.call(patient);
///     return result.fold(
///       (error) => false,
///       (success) {
///         getEntities();
///         return true;
///       },
///     );
///   }
///
///   Future<bool> deleteEntity(String id) async {
///     final result = await _deleteUseCase.call(id);
///     return result.fold(
///       (error) => false,
///       (success) {
///         getEntities();
///         return true;
///       },
///     );
///   }
///
///   Future<void> getEntities() async {
///     final result = await _getPatientsUseCase.call();
///     result.fold(
///       (error) => // Manejar error,
///       (patients) {
///         _patients = patients;
///         notifyListeners();
///       },
///     );
///   }
/// }
///
/// // En el Widget, coordinas ambos ViewModels:
/// ElevatedButton(
///   onPressed: () async {
///     final patient = formViewModel.mapDataToEntity();
///     if (patient != null) {
///       final success = await crudViewModel.addEntity(patient);
///       if (success) {
///         formViewModel.clearFormData();
///       }
///     }
///   },
///   child: Text('Guardar'),
/// )
/// ```
abstract class CrudViewModel<T extends Entity> with ChangeNotifier {
  CrudViewModel();

  // ==================== OPERACIONES CRUD ====================

  /// Crea una nueva entidad en el dominio.
  ///
  /// [entity]: La entidad a crear
  /// Returns: true si la operación fue exitosa, false en caso contrario
  Future<bool> addEntity(T entity);

  /// Lee una entidad del dominio por su ID.
  ///
  /// [id]: Identificador de la entidad a leer
  /// Returns: La entidad encontrada, o null si no existe o hay error
  Future<T?> getEntity(String id);

  /// Actualiza una entidad existente en el dominio.
  ///
  /// [entity]: La entidad con los datos actualizados
  /// Returns: true si la operación fue exitosa, false en caso contrario
  Future<bool> updateEntity(T entity);

  /// Elimina una entidad del dominio por su ID.
  ///
  /// [id]: Identificador de la entidad a eliminar
  /// Returns: true si la operación fue exitosa, false en caso contrario
  Future<bool> deleteEntity(String id);

  /// Obtiene la lista de entidades del dominio.
  ///
  /// Actualiza el estado interno de la lista y notifica a los listeners.
  Future<void> getEntities();
}
