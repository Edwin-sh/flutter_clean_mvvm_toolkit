import 'package:flutter_clean_mvvm_toolkit/src/core/errors/error_item.dart';

class OperationSuccess {
  final String _message;
  String get message => _message;
  const OperationSuccess(this._message);
}

class OperationFailure {
  final ErrorItem _errorItem;
  ErrorItem get errorItem => _errorItem;

  const OperationFailure(this._errorItem);
}
