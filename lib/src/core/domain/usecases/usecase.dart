import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_mvvm_toolkit/src/core/errors/error_item.dart';

/// Clase abstracta base para Casos de Uso que retornan un Future.
///
/// Los casos de uso encapsulan la lógica de negocio de la aplicación.
/// Siguiendo el principio de Single Responsibility, cada caso de uso
/// debe realizar una única operación de negocio.
///
/// Parámetros genéricos:
/// - [Type]: El tipo de dato que se devuelve en caso de éxito
/// - [Params]: El tipo de parámetros que recibe el caso de uso
///
/// Por convención, todos los casos de uso deben devolver un [Either]:
/// - Left: Contiene un [ErrorItem] en caso de error
/// - Right: Contiene el resultado exitoso de tipo [Type]
///
/// Ejemplo de uso:
/// ```dart
/// class GetUserUseCase extends UseCase<User, String> {
///   final UserRepository repository;
///
///   GetUserUseCase(this.repository);
///
///   @override
///   Future<Either<ErrorItem, User>> call(String userId) async {
///     return await repository.getUser(userId);
///   }
/// }
/// ```
abstract class UseCase<Type, Params> {
  /// Ejecuta el caso de uso con los parámetros proporcionados
  ///
  /// Retorna:
  /// - Left([ErrorItem]): Si ocurre un error durante la ejecución
  /// - Right([Type]): Si la operación se completa exitosamente
  Future<Either<ErrorItem, Type>> call(Params params);
}

/// Clase para casos de uso que no requieren parámetros.
///
/// Utiliza Equatable para permitir comparaciones por valor.
///
/// Ejemplo de uso:
/// ```dart
/// class GetCurrentUserUseCase extends UseCase<User, NoParams> {
///   @override
///   Future<Either<ErrorItem, User>> call(NoParams params) async {
///     // Implementación sin necesidad de parámetros
///   }
/// }
///
/// // Uso:
/// final result = await getCurrentUserUseCase(NoParams());
/// ```
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
