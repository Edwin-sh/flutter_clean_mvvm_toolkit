import 'package:flutter_clean_mvvm_toolkit/src/core/errors/error_code.dart';

import 'package:flutter_clean_mvvm_toolkit/src/utils/helpers/data_utils.dart';
import 'package:flutter_clean_mvvm_toolkit/src/core/errors/error_level_enum.dart';

/// Un modelo que representa un error estructurado en el dominio de la aplicación.
///
/// Incluye un mensaje principal, un código, detalles legibles y metadatos opcionales.
/// Esta clase sigue los principios de Clean Architecture manteniéndose independiente
/// de frameworks específicos.
class ErrorItem {
  /// Crea una nueva instancia inmutable de [ErrorItem].
  const ErrorItem({
    required this.title,
    required this.message,
    required this.code,
    this.details,
    this.errorLevel = ErrorLevelEnum.systemInfo,
  });

  /// Constructor factory para crear un [ErrorItem] desde un mapa JSON.
  ///
  /// [json]: Mapa que contiene los datos del error.
  /// Returns: Nueva instancia de [ErrorItem] con los datos deserializados.
  factory ErrorItem.fromJson(Map<String, dynamic> json) {
    return ErrorItem(
      title: DataUtils.getStringFromDynamic(json['title']),
      message: DataUtils.getStringFromDynamic(json['message']),
      code: ErrorCode.fromString(DataUtils.getStringFromDynamic(json['code'])),
      details: DataUtils.getStringFromDynamic(json['details']),
      errorLevel: ErrorLevelEnumExtension.fromString(
        DataUtils.getStringFromDynamic(json['errorLevel']),
      ),
    );
  }

  /// Constructor factory para crear un error desconocido por defecto.
  ///
  /// Returns: Instancia de [ErrorItem] con valores predeterminados para errores genéricos.
  factory ErrorItem.unknown({
    String message = 'Error desconocido',
    ErrorCode code = ErrorCode.unknownError,
  }) {
    return ErrorItem(
      title: 'Error desconocido',
      message: message,
      code: code,
      details: 'Ha ocurrido un error no especificado',
      errorLevel: ErrorLevelEnum.severe,
    );
  }

  /// Constructor factory para crear un error de red.
  ///
  /// [message]: Mensaje específico del error de red.
  /// [code]: Código específico del error (opcional).
  /// Returns: Instancia de [ErrorItem] configurada para errores de red.
  factory ErrorItem.network({
    String message = 'Error de conexión',
    ErrorCode code = ErrorCode.networkError,
    ErrorLevelEnum errorLevel = ErrorLevelEnum.warning,
  }) {
    return ErrorItem(
      title: 'Error de conexión',
      message: message,
      code: code,
      details: 'Verifique su conexión a internet e intente nuevamente',
      errorLevel: errorLevel,
    );
  }

  /// Constructor factory para crear un error de validación.
  ///
  /// [message]: Mensaje específico del error de validación.
  /// [field]: Campo que causó el error de validación (opcional).
  /// Returns: Instancia de [ErrorItem] configurada para errores de validación.
  factory ErrorItem.validation({
    String message = 'Error de validación',
    ErrorCode code = ErrorCode.validationError,
    ErrorLevelEnum errorLevel = ErrorLevelEnum.warning,
  }) {
    return ErrorItem(
      title: 'Error de validación',
      message: message,
      code: code,
      details:
          'Ha ocurrido un error de validación, corrija los datos e intenlelo de nuevo',
      errorLevel: errorLevel,
    );
  }

  /// Constructor factory para crear un error de autorización.
  ///
  /// Returns: Instancia de [ErrorItem] configurada para errores de autorización.
  factory ErrorItem.unauthorized() {
    return const ErrorItem(
      title: 'No autorizado',
      message: 'No autorizado',
      code: ErrorCode.unauthorized,
      details: 'No tiene permisos para realizar esta acción',
      errorLevel: ErrorLevelEnum.severe,
    );
  }

  /// Constructor factory para crear un error del servidor.
  ///
  /// [message]: Mensaje específico del error del servidor.
  /// Returns: Instancia de [ErrorItem] configurada para errores del servidor.
  factory ErrorItem.server({
    String message = 'Error del servidor',
    ErrorCode code = ErrorCode.serverError,
    ErrorLevelEnum errorLevel = ErrorLevelEnum.severe,
  }) {
    return ErrorItem(
      title: 'Error del servidor',
      message: message,
      code: code,
      details: 'Ha ocurrido un error en el servidor. Intente más tarde.',
      errorLevel: errorLevel,
    );
  }

  /// Título descriptivo del error.
  ///
  /// Este es un título breve que resume el tipo de error.
  ///
  final String title;

  /// Mensaje principal que describe el tipo de error.
  ///
  /// Este es el mensaje principal que se mostrará al usuario en la mayoría
  /// de los casos.
  final String message;

  /// Código único de error para identificación programática.
  ///
  /// Permite identificar tipos específicos de errores para manejo
  /// especializado en la lógica de la aplicación.
  final ErrorCode code;

  /// Explicación detallada del error (opcional).
  ///
  /// Información adicional que puede ser útil para el usuario o
  /// para debugging. Puede ser null si no se requieren detalles adicionales.
  final String? details;

  /// Enum que representa la severidad y nivel de manejo de un error.
  ///
  /// Esto es útil para que la UI determine cómo renderizar el error:
  /// - [ErrorLevelEnum.systemInfo]: Se registra internamente pero no se muestra al usuario
  /// - [ErrorLevelEnum.warning]: Problema menor, muestra un toast
  /// - [ErrorLevelEnum.severe]: Necesita atención, muestra modal u overlay
  /// - [ErrorLevelEnum.danger]: Problema crítico, reemplaza la pantalla (ej. página de error completa)
  final ErrorLevelEnum errorLevel;

  /// Retorna una copia de este [ErrorItem] con campos actualizados.
  ErrorItem copyWith({
    String? title,
    String? message,
    ErrorCode? code,
    String? details,
    ErrorLevelEnum? errorLevel,
  }) {
    return ErrorItem(
      title: title ?? this.title,
      message: message ?? this.message,
      code: code ?? this.code,
      details: details ?? this.details,
      errorLevel: errorLevel ?? this.errorLevel,
    );
  }

  /// Representación textual del error para propósitos de debugging.
  @override
  String toString() {
    final String detailsString = details != null ? ' | Detalles: $details' : '';
    return '<$title> $message ($code)$detailsString | Nivel: ${errorLevel.description}';
  }

  /// Retorna true si este error debe mostrarse al usuario.
  bool get shouldShowToUser => errorLevel.shouldShowToUser;

  /// Retorna true si este error es bloqueante para la operación actual.
  bool get isBlocking => errorLevel.isBlocking;

  /// Retorna el mensaje que debe mostrarse al usuario.
  ///
  /// Si hay detalles disponibles y el error debe mostrarse al usuario,
  /// combina el mensaje principal con los detalles.
  String get userMessage {
    if (!shouldShowToUser) return '';
    if (details != null && details!.isNotEmpty) {
      return '$message. $details';
    }
    return message;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ErrorItem &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code &&
          details == other.details &&
          errorLevel == other.errorLevel;

  /// Compara dos mapas para verificar igualdad.
  // ignore: unused_element
  bool _mapEquals(Map<String, dynamic> a, Map<String, dynamic> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || a[key] != b[key]) return false;
    }
    return true;
  }
}

/// Instancia por defecto de [ErrorItem] que representa un error genérico desconocido.
const ErrorItem defaultErrorItem = ErrorItem(
  title: 'Error desconocido',
  message: 'Error desconocido',
  code: ErrorCode.unknownError,
  details: 'Ha ocurrido un error no especificado',
  errorLevel: ErrorLevelEnum.systemInfo,
);
