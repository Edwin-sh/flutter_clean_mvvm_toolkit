# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.1] - 2026-01-05

### 🔄 Changed
- **CrudViewModel**: Refactored CRUD methods to return `Future<OperationResult<T>>` instead of `bool` or `T?`. This provides more context about the operation result, including errors and messages.
- **OperationResult**: Converted to a generic class `OperationResult<T>` to support typed data return and better error encapsulation.
- **OperationResultMixin**: Added `handleResult<T>(result)` method to automatically process `OperationResult` and notify listeners.

## [0.2.0] - 2026-01-05

### 🚨 Breaking Changes
- **Removed**: `CrudPageViewModel` and `CrudFormViewModel` (replaced with simpler architecture)
- **Changed**: `EntityFormViewModel.mapDataToEntity()` now returns `T?` and validates automatically
- **Changed**: `CrudViewModel` no longer has direct dependency on `EntityFormViewModel`

### ✨ Added
- **New**: `EntityFormViewModel` with automatic validation before entity creation
  - `buildEntityFromForm()`: New abstract method for entity construction
  - `mapDataToEntity()`: Now validates form before returning entity (returns `null` if invalid)
- **New**: Decoupled `CrudViewModel` architecture
  - Methods now receive entities as parameters
  - Returns explicit `bool` or `T?` for better error handling
  - No dependency on FormViewModel
- **New**: Complete validation system with two layers:
  - `FormValidators`: UI validators returning `String?` for Flutter widgets
  - `Validators`: Business logic validators returning `ErrorItem?`
- **New**: Additional validators:
  - `validateMatch()`: Compare two fields (e.g., password confirmation)
  - `validatePhone()`: Phone number validation
  - `validateUrl()`: URL format validation
  - `validatePasswordStrength()`: Strong password requirements
  - `validateAlphabetic()`: Only letters and spaces
  - `validateNumeric()`: Numeric values
  - `validateNotFutureDate()`: Date cannot be in the future
  - `validateRange()`: Numeric range validation
  - `validateStringLengthRange()`: String length between min and max
  - `validateMaxLength()`: Maximum string length
  - `validateNotNull()`: Null check with ErrorItem
  - `validateModelNotNull()`: Validates all Model fields are not null
- **New**: `Model` base class for Data Transfer Objects (DTOs)

### 🔄 Changed
- **Widget coordination**: Widgets now mediate communication between ViewModels
- **Improved**: `DefaultEntityForm` documentation with multiple usage examples
- **Improved**: Separation of concerns between form management and CRUD operations

### 📚 Documentation
- Complete README rewrite with new architecture
- Added comprehensive examples for all features
- Added best practices section
- Added validation system documentation
- Updated all code examples to reflect new patterns

### 🎯 Migration Guide from 0.1.x

#### Before (0.1.x):
```dart
class MyViewModel extends EntityFormViewModel<MyEntity> 
    implements CrudFormViewModel<MyEntity> {
  @override
  MyEntity mapDataToEntity() => MyEntity(...);
  
  @override
  Future<void> addEntity() async {
    final entity = mapDataToEntity();
    // CRUD logic here
  }
}
```

#### After (0.2.0):
```dart
// Separate ViewModels
class MyFormViewModel extends EntityFormViewModel<MyEntity> {
  @override
  MyEntity buildEntityFromForm() => MyEntity(...);
  // Only form management
}

class MyCrudViewModel extends CrudViewModel<MyEntity> {
  @override
  Future<bool> addEntity(MyEntity entity) async {
    // CRUD logic here
    return true;
  }
}

// Coordinate in Widget
final entity = formViewModel.mapDataToEntity(); // Auto-validates
if (entity != null) {
  await crudViewModel.addEntity(entity);
}
```

## [0.1.1] - 2026-01-02

### Added
- Added `read` mode to `FormType` enum to support view-only forms

## [0.1.0] - 2026-01-02

### Added
- Initial release of Flutter Clean MVVM Toolkit
- Core domain components:
  - `Entity` base class with Equatable
  - `UseCase` for Future-based business logic
  - `StreamUseCase` for reactive business logic
  - `NoParams` for parameterless use cases
- Error handling system:
  - `ErrorItem` with structured error representation
  - `ErrorCode` enum for error categorization
  - `ErrorLevelEnum` for error severity levels
- Presentation layer components:
  - `DefaultFormViewModel` with validation helpers
  - `CrudPageViewModel` for list/delete operations
  - `CrudFormViewModel` interface for create/update
  - `EntityFormViewModel` with ChangeNotifier
  - `OperationResultMixin` for success/failure handling
  - `OperationSuccess` and `OperationFailure` classes
  - `FormType` enum (create/update)
  - `DefaultEntityForm` widget base
- Utilities:
  - `DataUtils` for safe JSON parsing
- Complete documentation and examples
- MIT License

[0.2.0]: https://github.com/Edwin-sh/flutter_clean_mvvm_toolkit/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/Edwin-sh/flutter_clean_mvvm_toolkit/releases/tag/v0.1.1
[0.1.0]: https://github.com/Edwin-sh/flutter_clean_mvvm_toolkit/releases/tag/v0.1.0
