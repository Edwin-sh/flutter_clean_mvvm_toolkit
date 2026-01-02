import 'package:equatable/equatable.dart';

/// Clase base abstracta para todas las entidades del dominio.
///
/// Las entidades representan objetos de negocio con identidad única.
/// Utilizan Equatable para comparación por valor de sus propiedades.
///
/// Todas las entidades deben implementar:
/// - Un identificador único [id]
/// - Un método [copyWith] para crear copias inmutables
/// - Un método [toString] para representación textual
///
/// Ejemplo de uso:
/// ```dart
/// class User extends Entity {
///   @override
///   final String? id;
///   final String name;
///   final String email;
///
///   User({this.id, required this.name, required this.email});
///
///   @override
///   List<Object?> get props => [id, name, email];
///
///   @override
///   User copyWith({String? id, String? name, String? email}) {
///     return User(
///       id: id ?? this.id,
///       name: name ?? this.name,
///       email: email ?? this.email,
///     );
///   }
///
///   @override
///   String toString() => 'User(id: $id, name: $name, email: $email)';
/// }
/// ```
abstract class Entity extends Equatable {
  /// Identificador único de la entidad
  String? get id;

  /// Crea una copia de la instancia actual con campos actualizados
  Entity copyWith();

  @override
  String toString();
}
