/// Nivel de severidad de un error, determinando cómo debe ser manejado en la UI o lógica.
///
/// Cada nivel define un comportamiento específico para la presentación de errores:
/// - [systemInfo]: Para logs internos, sin retroalimentación visual al usuario
/// - [warning]: Problemas menores, manejados como retroalimentación no bloqueante (toast, banner)
/// - [severe]: Error bloqueante pero recuperable (modal, overlay)
/// - [danger]: Bloqueante y crítico, requiere pantalla completa o de recuperación
enum ErrorLevelEnum {
  /// Usado para logs internos. Sin retroalimentación en la UI.
  ///
  /// Estos errores son capturados para propósitos de debugging y monitoreo,
  /// pero no afectan la experiencia del usuario.
  systemInfo,

  /// Problema menor, manejado como retroalimentación no bloqueante.
  ///
  /// Se muestra típicamente como un toast, snackbar o banner que no interrumpe
  /// el flujo de trabajo del usuario.
  warning,

  /// Error bloqueante pero recuperable.
  ///
  /// Requiere atención del usuario, se muestra típicamente como un modal o
  /// overlay que debe ser reconocido antes de continuar.
  severe,

  /// Bloqueante y crítico. Requiere pantalla completa o de recuperación.
  ///
  /// Errores que impiden el funcionamiento normal de la aplicación y requieren
  /// una intervención significativa del usuario o reinicio de la sesión.
  danger,
}

/// Extensión para obtener propiedades útiles del [ErrorLevelEnum].
extension ErrorLevelEnumExtension on ErrorLevelEnum {
  /// Retorna true si el error debe mostrarse al usuario.
  bool get shouldShowToUser {
    switch (this) {
      case ErrorLevelEnum.systemInfo:
        return false;
      case ErrorLevelEnum.warning:
      case ErrorLevelEnum.severe:
      case ErrorLevelEnum.danger:
        return true;
    }
  }

  /// Retorna true si el error es bloqueante para la operación actual.
  bool get isBlocking {
    switch (this) {
      case ErrorLevelEnum.systemInfo:
      case ErrorLevelEnum.warning:
        return false;
      case ErrorLevelEnum.severe:
      case ErrorLevelEnum.danger:
        return true;
    }
  }

  /// Retorna una descripción legible del nivel de error.
  String get description {
    switch (this) {
      case ErrorLevelEnum.systemInfo:
        return 'Información del sistema';
      case ErrorLevelEnum.warning:
        return 'Advertencia';
      case ErrorLevelEnum.severe:
        return 'Error severo';
      case ErrorLevelEnum.danger:
        return 'Error crítico';
    }
  }

  /// Obtiene el [ErrorLevelEnum] correspondiente desde un string.
  ///
  /// [level]: String que representa el nivel de error.
  /// Returns: [ErrorLevelEnum] correspondiente o [ErrorLevelEnum.systemInfo] por defecto.
  static ErrorLevelEnum fromString(String? level) {
    if (level == null || level.isEmpty) return ErrorLevelEnum.systemInfo;

    return ErrorLevelEnum.values.firstWhere(
      (ErrorLevelEnum e) => e.name.toLowerCase() == level.toLowerCase(),
      orElse: () => ErrorLevelEnum.systemInfo,
    );
  }
}
