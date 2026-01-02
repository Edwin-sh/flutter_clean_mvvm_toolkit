# Flutter Clean MVVM Toolkit 🏗️

[![pub package](https://img.shields.io/pub/v/flutter_clean_mvvm_toolkit.svg)](https://pub.dev/packages/flutter_clean_mvvm_toolkit)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A comprehensive Flutter toolkit for implementing **Clean Architecture** with **MVVM** pattern. Provides foundational components and patterns for building scalable, maintainable, and testable Flutter applications.

## ✨ Features

- **🏛️ Clean Architecture Base Components**
  - Entity base class with Equatable
  - UseCase and StreamUseCase abstract classes
  - Repository pattern support

- **�� MVVM ViewModels**
  - CrudPageViewModel for list & delete operations
  - CrudFormViewModel for create/update operations
  - EntityFormViewModel with ChangeNotifier
  - OperationResultMixin for success/failure handling

- **🔥 Error Handling System**
  - Structured ErrorItem with levels (systemInfo, warning, severe, danger)
  - ErrorCode enum for categorization
  - Either<ErrorItem, T> pattern throughout

- **📝 Form Management**
  - FormType enum (create/update)
  - DefaultFormViewModel with validation helpers
  - Type-safe form state management

- **🛠️ Utilities**
  - DataUtils for safe JSON parsing
  - Form validators

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_clean_mvvm_toolkit: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### 1. Create an Entity

```dart
import 'package:flutter_clean_mvvm_toolkit/flutter_clean_mvvm_toolkit.dart';

class User extends Entity {
  @override
  final String? id;
  final String name;
  final String email;

  User({this.id, required this.name, required this.email});

  @override
  List<Object?> get props => [id, name, email];

  @override
  User copyWith({String? id, String? name, String? email}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}
```

### 2. Create a Use Case

```dart
class GetUsersUseCase extends StreamUseCase<List<User>, NoParams> {
  final UserRepository repository;

  GetUsersUseCase(this.repository);

  @override
  Stream<Either<ErrorItem, List<User>>> call(NoParams params) {
    return repository.watchUsers();
  }
}
```

### 3. Create a ViewModel for Listing

```dart
class UserViewModel extends CrudPageViewModel<User> with OperationResultMixin {
  final GetUsersUseCase _getUsersUseCase;
  final DeleteUserUseCase _deleteUserUseCase;

  UserViewModel(this._getUsersUseCase, this._deleteUserUseCase) {
    getEntities();
  }

  List<User> _users = [];
  List<User> get users => _users;

  bool _loading = false;
  bool get loading => _loading;

  @override
  Future<void> getEntities() async {
    _loading = true;
    notifyListeners();
    
    _getUsersUseCase(NoParams()).listen((either) {
      either.fold(
        (error) {
          setOperationFailure(OperationFailure(error));
          _loading = false;
          notifyListeners();
        },
        (users) {
          _users = users;
          _loading = false;
          notifyListeners();
        },
      );
    });
  }

  @override
  Future<void> delete(String? id) async {
    if (id == null) return;
    
    final result = await _deleteUserUseCase(id);
    result.fold(
      (error) => setOperationFailure(OperationFailure(error)),
      (_) => setOperationSuccess(OperationSuccess('Usuario eliminado')),
    );
  }
}
```

### 4. Create a Form ViewModel

```dart
class UserFormViewModel extends EntityFormViewModel<User> 
    with OperationResultMixin 
    implements CrudFormViewModel<User> {
  final AddUserUseCase _addUserUseCase;
  final UpdateUserUseCase _updateUserUseCase;

  UserFormViewModel(this._addUserUseCase, this._updateUserUseCase) {
    createFormState();
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Future<void> addEntity() async {
    final user = mapDataToEntity();
    final result = await _addUserUseCase(user);
    
    result.fold(
      (error) => setOperationFailure(OperationFailure(error)),
      (_) => setOperationSuccess(OperationSuccess('Usuario creado')),
    );
  }

  @override
  Future<void> updateEntity() async {
    final user = mapDataToEntity();
    final result = await _updateUserUseCase(user);
    
    result.fold(
      (error) => setOperationFailure(OperationFailure(error)),
      (_) => setOperationSuccess(OperationSuccess('Usuario actualizado')),
    );
  }

  @override
  User mapDataToEntity() {
    return User(
      name: nameController.text,
      email: emailController.text,
    );
  }

  @override
  void loadDataFromEntity(User entity) {
    nameController.text = entity.name;
    emailController.text = entity.email;
  }

  @override
  Future<void> getEntity(String? id) async {
    // Implementar lógica de obtención
  }

  @override
  void clearFormData() {
    nameController.clear();
    emailController.clear();
  }
}
```

## 🏗️ Architecture

This toolkit follows Clean Architecture principles with three main layers:

```
┌─────────────────────────────────────┐
│       Presentation Layer            │
│   (ViewModels, Widgets, UI)         │
└─────────────┬───────────────────────┘
              │
┌─────────────▼───────────────────────┐
│         Domain Layer                │
│  (Entities, UseCases, Repositories) │
└─────────────┬───────────────────────┘
              │
┌─────────────▼───────────────────────┐
│          Data Layer                 │
│  (Models, DataSources, Repos Impl)  │
└─────────────────────────────────────┘
```

## 📚 Core Components

### Entity
Base class for all domain entities with identity and equality.

### UseCase
Abstract class for business logic that returns `Future<Either<ErrorItem, T>>`.

### StreamUseCase
Abstract class for reactive business logic that returns `Stream<Either<ErrorItem, T>>`.

### ErrorItem
Structured error representation with:
- title, message, details
- ErrorCode for categorization
- ErrorLevelEnum for severity (systemInfo, warning, severe, danger)

### ViewModels
- **CrudPageViewModel**: For list and delete operations
- **CrudFormViewModel**: Interface for create/update operations
- **EntityFormViewModel**: Base implementation with ChangeNotifier

### OperationResultMixin
Provides success/failure state management for ViewModels.

## 🧪 Testing

The toolkit is designed with testability in mind. Use `mocktail` for mocking:

```dart
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late GetUsersUseCase useCase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUsersUseCase(mockRepository);
  });

  test('should return list of users from repository', () async {
    // Arrange
    final users = [User(id: '1', name: 'Test', email: 'test@test.com')];
    when(() => mockRepository.watchUsers()).thenAnswer(
      (_) => Stream.value(Right(users)),
    );

    // Act
    final result = useCase(NoParams());

    // Assert
    expect(result, emits(Right(users)));
  });
}
```

## 📖 Documentation

For more detailed documentation, visit [our wiki](https://github.com/Edwin-sh/flutter_clean_mvvm_toolkit/wiki).

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

Created and maintained by [Edwin-sh](https://github.com/Edwin-sh).

## 🙏 Acknowledgments

Inspired by Clean Architecture principles and best practices from the Flutter community.
