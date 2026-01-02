import 'package:flutter_clean_mvvm_toolkit/src/core/domain/entities/entity.dart';

/// Interfaz base para ViewModels de formularios CRUD desacoplados de la UI
///
/// Contrato para ViewModels que gestionan entidades del dominio
/// siguiendo Clean Architecture. Permite:
/// - Crear (addEntity)
/// - Leer (getEntity)
/// - Actualizar (updateEntity)
/// - Eliminar (deleteEntity)
/// - Sincronizar datos entre la entidad y los campos del formulario
///
/// Genérico:
/// - [T]: Entidad del dominio gestionada por el formulario
///
/// Todas las operaciones retornan `Either<ErrorItem, T>` para manejo centralizado de errores.
///
/// Ejemplo de implementación:
/// ```dart
/// class PatientFormViewModel extends EntityFormViewModel<Patient>
///     implements CrudFormViewModel<Patient> {
///   @override
///   Future<void> addEntity() async {
///     // Lógica para guardar usando caso de uso
///   }
///
///   @override
///   void loadDataFromEntity(Patient patient) {
///     nameController.text = patient.name;
///   }
///   // ...
/// }
/// ```
abstract class CrudFormViewModel<T extends Entity>{
  /// Guarda una nueva entidad en el dominio
  ///
  /// [transaction]: Transacción Firestore opcional para operaciones atómicas
  ///
  /// Retorna:
  /// - `true` si guardó exitosamente
  /// - `false` si falló
  /// - `null` si fue cancelado por el usuario
  Future<void> addEntity();

  /// Lee una entidad del dominio por su ID
  ///
  /// [id]: Identificador de la entidad a leer
  ///
  /// Carga los datos en el ViewModel para su visualización/edición
  Future<void> getEntity(String? id);

  /// Actualiza una entidad existente en el dominio
  ///
  /// Retorna el ID de la entidad actualizada, o null si falló
  Future<void> updateEntity();

  /// Carga datos desde la entidad hacia los campos del formulario
  ///
  /// Toma la entidad almacenada en el ViewModel y popula
  /// los controllers/campos del formulario para mostrarla al usuario
  void loadDataFromEntity(T entity);

  /// Mapea datos del formulario a la entidad para guardar o actualizar
  ///
  /// Toma los valores de los controllers/campos del formulario
  /// y crea/actualiza la entidad en el ViewModel
  T mapDataToEntity();
}
