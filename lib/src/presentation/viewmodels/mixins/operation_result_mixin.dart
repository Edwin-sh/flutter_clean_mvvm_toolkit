import 'package:flutter/material.dart';

import 'package:flutter_clean_mvvm_toolkit/src/presentation/models/operation_result.dart';

mixin OperationResultMixin on ChangeNotifier {
  OperationSuccess? _operationSuccess;
  OperationFailure? _operationFailure;

  OperationSuccess? get operationSuccess => _operationSuccess;
  OperationFailure? get operationFailure => _operationFailure;

  void setOperationSuccess(OperationSuccess operationResult) {
    _operationSuccess = operationResult;
    notifyListeners();
    debugPrint('Operación exitosa: ${operationResult.message}');
    // _operationFailure = null;
    _operationSuccess = null;
    notifyListeners();
  }

  void setOperationFailure(OperationFailure operationResult) {
    _operationFailure = operationResult;
    notifyListeners();
    debugPrint('Operación fallida: ${operationResult.errorItem}');
    _operationSuccess = null;
    // _operationFailure = null;
    notifyListeners();
  }
}
