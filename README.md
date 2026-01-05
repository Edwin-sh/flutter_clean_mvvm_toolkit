# Flutter Clean MVVM Toolkit 🏗️

[![pub package](https://img.shields.io/pub/v/flutter_clean_mvvm_toolkit.svg)](https://pub.dev/packages/flutter_clean_mvvm_toolkit)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A comprehensive Flutter toolkit for implementing **Clean Architecture** with **MVVM** pattern. Provides foundational components and best practices for building scalable, maintainable, and testable Flutter applications.

## ✨ Features

### 🏛️ Clean Architecture Components
- **Entity**: Base class with Equatable for value comparison
- **UseCase**: Abstract class for Future-based business logic
- **StreamUseCase**: Abstract class for reactive business logic
- **Model**: Base class for Data Transfer Objects (DTOs)

### 📝 MVVM ViewModels
- **EntityFormViewModel**: Manages form fields, validation, and data transformation
- **CrudViewModel**: Handles CRUD operations with Use Cases
- **DefaultFormViewModel**: Base form state management with FormKey
- **OperationResultMixin**: Success/failure state handling

### 🔥 Error Handling System
- **ErrorItem**: Structured error representation with severity levels
- **ErrorCode**: Categorized error types (network, validation, unauthorized, etc.)
- **ErrorLevelEnum**: Severity levels (systemInfo, warning, severe, danger)

### ✅ Validation System
- **FormValidators**: UI validators returning `String?` for Flutter widgets
- **Validators**: Business logic validators returning `ErrorItem?` for use cases
- Common validations: email, phone, URL, password strength, numeric, alphabetic, date ranges, and more

### 🛠️ Utilities
- **DataUtils**: Safe JSON parsing helpers
- **FormType**: Enum for form modes (create, edit, read)
- **DefaultEntityForm**: Base widget for entity forms

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_clean_mvvm_toolkit: ^0.2.0
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### 1. Define your Entity

```dart
import 'package:flutter_clean_mvvm_toolkit/flutter_clean_mvvm_toolkit.dart';

class Patient extends Entity {
  @override
  final String? id;
  final String name;
  final int age;
  final String email;

  Patient({
    this.id,
    required this.name,
    required this.age,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, age, email];

  @override
  Patient copyWith({String? id, String? name, int? age, String? email}) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
    );
  }

  @override
  String toString() => 'Patient(id: $id, name: $name, age: $age, email: $email)';
}
```

### 2. Create your Use Cases

```dart
class CreatePatientUseCase extends UseCase<Patient, Patient> {
  final PatientRepository repository;

  CreatePatientUseCase(this.repository);

  @override
  Future<Either<ErrorItem, Patient>> call(Patient params) async {
    // Validaciones de negocio
    if (params.age < 18) {
      return Left(ErrorItem.validation(
        message: 'El paciente debe ser mayor de edad',
      ));
    }
    
    return await repository.create(params);
  }
}

class GetPatientsUseCase extends UseCase<List<Patient>, NoParams> {
  final PatientRepository repository;

  GetPatientsUseCase(this.repository);

  @override
  Future<Either<ErrorItem, List<Patient>>> call(NoParams params) async {
    return await repository.getAll();
  }
}
```

### 3. Create Form ViewModel

```dart
class PatientFormViewModel extends EntityFormViewModel<Patient> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();

  PatientFormViewModel() {
    createFormState(); // Inicializa el FormKey
  }

  @override
  void loadDataFromEntity(Patient entity) {
    nameController.text = entity.name;
    ageController.text = entity.age.toString();
    emailController.text = entity.email;
    formType = FormType.edit;
  }

  @override
  Patient buildEntityFromForm() {
    return Patient(
      name: nameController.text,
      age: int.parse(ageController.text),
      email: emailController.text,
    );
  }

  @override
  void clearFormData() {
    nameController.clear();
    ageController.clear();
    emailController.clear();
    formType = FormType.create;
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
```

### 4. Create CRUD ViewModel

```dart
class PatientCrudViewModel extends CrudViewModel<Patient> {
  final CreatePatientUseCase _createUseCase;
  final GetPatientsUseCase _getPatientsUseCase;
  final UpdatePatientUseCase _updateUseCase;
  final DeletePatientUseCase _deleteUseCase;

  List<Patient> _patients = [];
  List<Patient> get patients => _patients;

  PatientCrudViewModel(
    this._createUseCase,
    this._getPatientsUseCase,
    this._updateUseCase,
    this._deleteUseCase,
  ) {
    getEntities();
  }

  @override
  Future<OperationResult<Patient>> addEntity(Patient entity) async {
    final result = await _createUseCase.call(entity);
    return result.fold(
      (error) => OperationResult.failure(error),
      (patient) {
        getEntities();
        return OperationResult.success(patient);
      },
    );
  }

  @override
  Future<OperationResult<Patient>> getEntity(String id) async {
    final result = await _getPatientUseCase.call(id);
    return result.fold(
      (error) => OperationResult.failure(error),
      (patient) => OperationResult.success(patient),
    );
  }

  @override
  Future<OperationResult<Patient>> updateEntity(Patient entity) async {
    final result = await _updateUseCase.call(entity);
    return result.fold(
      (error) => OperationResult.failure(error),
      (patient) {
        getEntities();
        return OperationResult.success(patient);
      },
    );
  }

  @override
  Future<OperationResult<void>> deleteEntity(String id) async {
    final result = await _deleteUseCase.call(id);
    return result.fold(
      (error) => OperationResult.failure(error),
      (success) {
        getEntities();
        return OperationResult.success(null);
      },
    );
  }

  @override
  Future<void> getEntities() async {
    final result = await _getPatientsUseCase.call(NoParams());
    result.fold(
      (error) {
        // Manejar error
      },
      (patients) {
        _patients = patients;
        notifyListeners();
      },
    );
  }
}
```

### 5. Build your UI

```dart
class PatientFormScreen extends StatelessWidget {
  final PatientFormViewModel formViewModel;
  final PatientCrudViewModel crudViewModel;

  const PatientFormScreen({
    required this.formViewModel,
    required this.crudViewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nuevo Paciente')),
      body: Form(
        key: formViewModel.formState,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: formViewModel.nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) => FormValidators.validateNoEmpty(value, 'el nombre'),
              ),
              TextFormField(
                controller: formViewModel.ageController,
                decoration: InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (value) => FormValidators.validateIsNumeric(value, 'la edad'),
              ),
              TextFormField(
                controller: formViewModel.emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => FormValidators.validateEmail(value),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // El FormViewModel valida automáticamente
                  final patient = formViewModel.mapDataToEntity();
                  
                  if (patient != null) {
                    final result = formViewModel.formType == FormType.create
                        ? await crudViewModel.addEntity(patient)
                        : await crudViewModel.updateEntity(patient);
                    
                    if (result.isSuccess) {
                      formViewModel.clearFormData();
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text(formViewModel.formType == FormType.create ? 'Crear' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## 📚 Core Concepts

### ViewModels Architecture

This toolkit uses a **decoupled ViewModel architecture**:

#### EntityFormViewModel
- **Responsibility**: Manages form fields, validation, and data transformation
- **Does NOT**: Execute CRUD operations or communicate with Use Cases
- **Methods**:
  - `loadDataFromEntity(entity)`: Populates form fields from entity
  - `mapDataToEntity()`: Creates entity from form (validates first, returns `null` if invalid)
  - `buildEntityFromForm()`: Abstract method to implement entity construction
  - `clearFormData()`: Clears all form fields

#### CrudViewModel
- **Responsibility**: Executes CRUD operations via Use Cases
- **Does NOT**: Know about form fields or controllers
- **Methods**:
  - `addEntity(entity)`: Create operation → `Future<OperationResult<T>>`
  - `getEntity(id)`: Read operation → `Future<OperationResult<T>>`
  - `updateEntity(entity)`: Update operation → `Future<OperationResult<T>>`
  - `deleteEntity(id)`: Delete operation → `Future<OperationResult<void>>`
  - `getEntities()`: List operation → `Future<void>`

#### Widget Coordination
The **Widget** acts as the mediator between both ViewModels:

```dart
// Widget coordinates the communication
final patient = formViewModel.mapDataToEntity(); // Validates & builds entity
if (patient != null) {
  final result = await crudViewModel.addEntity(patient); // Executes operation
  if (result.isSuccess) formViewModel.clearFormData(); // Cleans up
}
```

### Validation System

#### FormValidators (UI Layer)
Returns `String?` for direct use in Flutter validators:

```dart
TextFormField(
  validator: (value) => FormValidators.validateEmail(value),
)
```

Available validators:
- `validateNoEmpty(value, fieldName)`
- `validateEmail(value)`
- `validateMinLength(value, minLength, fieldName)`
- `validateIsNumeric(value, fieldName)`
- `validateMatch(value, other, message)`
- `validatePhone(value, fieldName)`
- `validateUrl(value, fieldName)`
- `validatePasswordStrength(value, fieldName)`

#### Validators (Business Logic Layer)
Returns `ErrorItem?` for use in Use Cases:

```dart
final error = Validators.validateEmail(email);
if (error != null) {
  return Left(error); // Return Either with error
}
```

Available validators:
- All from FormValidators, plus:
- `validateNotNull(value, fieldName)`
- `validateModelNotNull(model)`
- `validateMaxLength(value, maxLength, fieldName)`
- `validateRange(value, min, max, fieldName)`
- `validateStringLengthRange(value, minLength, maxLength, fieldName)`
- `validateAlphabetic(value, fieldName)`
- `validateNotFutureDate(date, fieldName)`

### Error Handling

```dart
class GetPatientUseCase extends UseCase<Patient, String> {
  @override
  Future<Either<ErrorItem, Patient>> call(String id) async {
    try {
      final patient = await repository.getById(id);
      return Right(patient);
    } catch (e) {
      return Left(ErrorItem.network(
        message: 'No se pudo obtener el paciente',
      ));
    }
  }
}
```

Error types:
- `ErrorItem.validation()`: Form/data validation errors
- `ErrorItem.network()`: Network connectivity errors
- `ErrorItem.unauthorized()`: Authentication errors
- `ErrorItem.unknown()`: Generic errors

## 🎯 Best Practices

1. **Separate Concerns**: Keep FormViewModel for UI and CrudViewModel for business logic
2. **Validate Early**: Use FormValidators in UI, Validators in Use Cases
3. **Use Either**: Always return `Either<ErrorItem, T>` from Use Cases
4. **Coordinate in Widget**: Let the Widget mediate between ViewModels
5. **Dispose Properly**: Always dispose controllers in FormViewModel
6. **Test Independently**: Each ViewModel should be testable without the other

## 📖 Documentation

For complete API documentation, visit [pub.dev documentation](https://pub.dev/documentation/flutter_clean_mvvm_toolkit/latest/).

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Edwin Martinez**
- GitHub: [@Edwin-sh](https://github.com/Edwin-sh)

## 🙏 Acknowledgments

Inspired by Clean Architecture principles and MVVM pattern best practices in Flutter development.
