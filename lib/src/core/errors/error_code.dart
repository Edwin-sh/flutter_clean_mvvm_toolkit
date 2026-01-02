enum ErrorCode {
  //Listado de codigos de error con su respectivo string
  unknownError('ERR_UNKNOWN'),
  systemError('ERR_SYSTEM'),
  warningError('ERR_WARNING'),
  networkError('ERR_NETWORK'),
  databaseError('ERR_DATABASE'),
  severeError('ERR_SEVERE'),
  validationError('ERR_VALIDATION'),
  unauthorized('ERR_UNAUTHORIZED'),
  serverError('ERR_SERVER'),
  customError('ERR_CUSTOM'),
  duplicateEntry('ERR_DUPLICATE_ENTRY'),
  notFound('ERR_NOT_FOUND'),
  unexpected('ERR_UNEXPECTED'),
  timeout('ERR_TIMEOUT'),
  endTimeBeforeStartTime('END_TIME_BEFORE_START_TIME'),
  invalidDateRange('INVALID_DATE_RANGE'),
  blockExceedsMaxDuration('BLOCK_EXCEEDS_MAX_DURATION'),
  startTimeInPast('START_TIME_IN_PAST'),
  timeConflict('TIME_CONFLICT');

  final String code;
  const ErrorCode(this.code);
  static ErrorCode fromString(String code) {
    return ErrorCode.values.firstWhere(
      (e) => e.code == code,
      orElse: () => ErrorCode.unknownError,
    );
  }
}
