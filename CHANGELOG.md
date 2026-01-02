# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

[0.1.0]: https://github.com/Edwin-sh/flutter_clean_mvvm_toolkit/releases/tag/v0.1.0
