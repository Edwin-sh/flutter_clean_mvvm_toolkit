import 'package:flutter_clean_mvvm_toolkit/src/core/errors/error_item.dart';

/// Representa el resultado de una operación en la capa de presentación.
///
/// [T] es el tipo de dato que retorna la operación en caso de éxito.
class OperationResult<T> {
  final T? data;
  final ErrorItem? error;
  final String? message;

  const OperationResult._({this.data, this.error, this.message});

  /// Crea un resultado exitoso con datos opcionales y un mensaje.
  factory OperationResult.success(T? data, {String? message}) {
    return OperationResult._(data: data, message: message);
  }

  /// Crea un resultado fallido con un [ErrorItem].
  factory OperationResult.failure(ErrorItem error) {
    return OperationResult._(error: error);
  }

  /// Indica si la operación fue exitosa.
  bool get isSuccess => error == null;

  /// Indica si la operación falló.
  bool get isFailure => error != null;
}

/// Clase de conveniencia para mensajes de éxito (mantenida por compatibilidad).
class OperationSuccess {
  final String _message;
  String get message => _message;
  const OperationSuccess(this._message);
}

/// Clase de conveniencia para errores (mantenida por compatibilidad).
class OperationFailure {
  final ErrorItem _errorItem;
  ErrorItem get errorItem => _errorItem;

  const OperationFailure(this._errorItem);
}
