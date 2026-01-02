import 'package:flutter/widgets.dart';
import 'package:flutter_clean_mvvm_toolkit/src/core/domain/entities/entity.dart';

/// Interfaz base para ViewModels de páginas CRUD desacopladas de la UI
///
/// Contrato para ViewModels que gestionan entidades del dominio
/// siguiendo Clean Architecture. Permite:
/// - Listar (getEntities)
/// - Eliminar (delete)
///
/// Genérico:
/// - [T]: Entidad del dominio gestionada por la página
///
/// Todas las operaciones retornan `Either<ErrorItem, T>` para manejo centralizado de errores.
///
/// Ejemplo de implementación:
/// ```dart
/// class PatientPageViewModel extends CrudPageViewModel<Patient> {
///   @override
///   Future<void> getEntities() async {
///     // Lógica para obtener la lista de pacientes
///   }
///
///   @override
///   Future<void> delete(String? id) async {
///     // Lógica para eliminar un paciente
///   }
///   // ...
/// }
/// ```
abstract class CrudPageViewModel<T extends Entity> with ChangeNotifier {
  /// Guarda una nueva entidad en el dominio
  ///
  /// [transaction]: Transacción Firestore opcional para operaciones atómicas
  ///
  /// Retorna:
  /// - `true` si guardó exitosamente
  /// - `false` si falló
  /// - `null` si fue cancelado por el usuario
  Future<void> getEntities();

  /// Lee una entidad del dominio por su ID
  ///
  /// [id]: Identificador de la entidad a leer
  ///
  /// Carga los datos en el ViewModel para su visualización/edición
  Future<void> delete(String? id);
}
