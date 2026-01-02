import 'package:dartz/dartz.dart';
import 'package:flutter_clean_mvvm_toolkit/src/core/errors/error_item.dart';

/// Clase abstracta base para Casos de Uso que retornan un Stream.
///
/// Similar a [UseCase], pero diseñado para operaciones que emiten
/// múltiples valores a lo largo del tiempo (datos en tiempo real,
/// suscripciones a cambios, etc.).
///
/// Parámetros genéricos:
/// - [Type]: El tipo de dato que el Stream emite en caso de éxito
/// - [Params]: El tipo de parámetros que recibe el caso de uso
///
/// El Stream emite valores Either que pueden ser:
/// - Left([ErrorItem]): Si ocurre un error
/// - Right([Type]): Con cada valor exitoso emitido
///
/// Ejemplo de uso:
/// ```dart
/// class WatchUsersUseCase extends StreamUseCase<List<User>, NoParams> {
///   final UserRepository repository;
///
///   WatchUsersUseCase(this.repository);
///
///   @override
///   Stream<Either<ErrorItem, List<User>>> call(NoParams params) {
///     return repository.watchUsers();
///   }
/// }
///
/// // Uso:
/// watchUsersUseCase(NoParams()).listen((either) {
///   either.fold(
///     (error) => print('Error: $error'),
///     (users) => print('Users: $users'),
///   );
/// });
/// ```
abstract class StreamUseCase<Type, Params> {
  /// Ejecuta el caso de uso con los parámetros proporcionados
  ///
  /// Retorna un Stream que emite:
  /// - Left([ErrorItem]): Cuando ocurre un error
  /// - Right([Type]): Con cada valor exitoso
  Stream<Either<ErrorItem, Type>> call(Params params);
}
