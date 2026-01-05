import 'package:flutter/material.dart';

import 'package:flutter_clean_mvvm_toolkit/src/presentation/models/operation_result.dart';

/// Mixin para gestionar y notificar resultados de operaciones en los ViewModels.
///
/// Proporciona un mecanismo para notificar a la UI sobre el éxito o fracaso
/// de una operación asíncrona (como un guardado o eliminación).
mixin OperationResultMixin on ChangeNotifier {
  OperationSuccess? _operationSuccess;
  OperationFailure? _operationFailure;

  /// Obtiene el último éxito notificado.
  OperationSuccess? get operationSuccess => _operationSuccess;

  /// Obtiene el último fallo notificado.
  OperationFailure? get operationFailure => _operationFailure;

  /// Procesa un [OperationResult] genérico y notifica a los listeners.
  ///
  /// Este es el método recomendado para usar con los nuevos retornos de CrudViewModel.
  void handleResult<T>(OperationResult<T> result) {
    if (result.isSuccess) {
      setOperationSuccess(
        OperationSuccess(result.message ?? 'Operación exitosa'),
      );
    } else if (result.error != null) {
      setOperationFailure(OperationFailure(result.error!));
    }
  }

  /// Notifica un éxito con un mensaje.
  void setOperationSuccess(OperationSuccess operationResult) {
    _operationSuccess = operationResult;
    notifyListeners();
    debugPrint('Operación exitosa: ${operationResult.message}');
    _operationSuccess = null;
    notifyListeners();
  }

  /// Notifica un fallo con un [ErrorItem].
  void setOperationFailure(OperationFailure operationResult) {
    _operationFailure = operationResult;
    notifyListeners();
    debugPrint('Operación fallida: ${operationResult.errorItem}');
    _operationFailure = null;
    notifyListeners();
  }
}
