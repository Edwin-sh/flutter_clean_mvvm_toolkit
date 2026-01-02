/// Flutter Clean MVVM Toolkit
/// 
/// A comprehensive Flutter toolkit for implementing Clean Architecture
/// with MVVM pattern. Provides foundational components for building
/// scalable and maintainable Flutter applications.
///
/// ## Features
/// - **Clean Architecture** base components (Entity, UseCase, StreamUseCase)
/// - **Error Handling** system (ErrorItem, ErrorCode, ErrorLevelEnum)
/// - **MVVM ViewModels** base classes for CRUD operations
/// - **Form Management** with type-safe state handling
/// - **Operation Results** for success/failure tracking
///
/// ## Usage
/// ```dart
/// import 'package:flutter_clean_mvvm_toolkit/flutter_clean_mvvm_toolkit.dart';
/// ```
library flutter_clean_mvvm_toolkit;

// ==================== CORE - DOMAIN ====================

/// Domain Layer - Entities
export 'src/core/domain/entities/entity.dart';

/// Domain Layer - Use Cases
export 'src/core/domain/usecases/usecase.dart';
export 'src/core/domain/usecases/stream_usecase.dart';

// ==================== CORE - ERRORS ====================

/// Error Handling System
export 'src/core/errors/error_item.dart';
export 'src/core/errors/error_code.dart';
export 'src/core/errors/error_level_enum.dart';

// ==================== PRESENTATION ====================

/// Presentation Layer - ViewModels Base
export 'src/presentation/viewmodels/base/default_form_view_model.dart';

/// Presentation Layer - ViewModels CRUD
export 'src/presentation/viewmodels/crud/crud_page_view_model.dart';
export 'src/presentation/viewmodels/crud/crud_form_view_model.dart';
export 'src/presentation/viewmodels/crud/entity_form_view_model.dart';

/// Presentation Layer - Mixins
export 'src/presentation/viewmodels/mixins/operation_result_mixin.dart';

/// Presentation Layer - Models (UI States)
export 'src/presentation/models/operation_result.dart';

/// Presentation Layer - Widgets
export 'src/presentation/widgets/default_entity_form.dart';

/// Presentation Layer - Enums
export 'src/presentation/enums/form_type.dart';

// ==================== UTILS ====================

/// Utilities - Helpers
export 'src/utils/helpers/data_utils.dart';
