import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm_toolkit/src/core/domain/entities/entity.dart';
import 'package:flutter_clean_mvvm_toolkit/src/presentation/models/operation_result.dart';

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
///   Future<OperationResult<Patient>> addEntity(Patient patient) async {
///     final result = await _createUseCase.call(patient);
///     return result.fold(
///       (error) => OperationResult.failure(error),
///       (success) {
///         getEntities(); // Recargar lista
///         return OperationResult.success(success);
///       },
///     );
///   }
///
///   Future<OperationResult<Patient>> getEntity(String id) async {
///     final result = await _getUseCase.call(id);
///     return result.fold(
///       (error) => OperationResult.failure(error),
///       (patient) => OperationResult.success(patient),
///     );
///   }
///
///   Future<OperationResult<Patient>> updateEntity(Patient patient) async {
///     final result = await _updateUseCase.call(patient);
///     return result.fold(
///       (error) => OperationResult.failure(error),
///       (success) {
///         getEntities();
///         return OperationResult.success(success);
///       },
///     );
///   }
///
///   Future<OperationResult<void>> deleteEntity(String id) async {
///     final result = await _deleteUseCase.call(id);
///     return result.fold(
///       (error) => OperationResult.failure(error),
///       (success) {
///         getEntities();
///         return OperationResult.success(null);
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
///       final result = await crudViewModel.addEntity(patient);
///       if (result.isSuccess) {
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
  /// Returns: [OperationResult] con la entidad creada o el error
  Future<OperationResult<T>> addEntity(T entity);

  /// Lee una entidad del dominio por su ID.
  ///
  /// [id]: Identificador de la entidad a leer
  /// Returns: [OperationResult] con la entidad encontrada o el error
  Future<OperationResult<T>> getEntity(String id);

  /// Actualiza una entidad existente en el dominio.
  ///
  /// [entity]: La entidad con los datos actualizados
  /// Returns: [OperationResult] con la entidad actualizada o el error
  Future<OperationResult<T>> updateEntity(T entity);

  /// Elimina una entidad del dominio por su ID.
  ///
  /// [id]: Identificador de la entidad a eliminar
  /// Returns: [OperationResult] indicando éxito o el error
  Future<OperationResult<void>> deleteEntity(String id);

  /// Obtiene la lista de entidades del dominio.
  ///
  /// Actualiza el estado interno de la lista y notifica a los listeners.
  Future<void> getEntities();
}
