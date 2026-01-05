import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm_toolkit/src/core/domain/entities/entity.dart';
import 'package:flutter_clean_mvvm_toolkit/src/presentation/viewmodels/crud/entity_form_view_model.dart';

/// Widget base abstracto para formularios de entidades.
///
/// - [T]: Tipo de entidad del dominio
/// - [VM]: Tipo de ViewModel que extiende EntityFormViewModel<T>
/// - Provee acceso al ViewModel de formulario para gestión de campos
///
/// El widget solo se encarga de la presentación del formulario.
/// Si necesitas operaciones CRUD, puedes agregar un CrudViewModel
/// adicional en tu implementación concreta.
///
/// Ejemplo de uso básico (solo formulario):
/// ```dart
/// class PatientForm extends DefaultEntityForm<Patient, PatientFormViewModel> {
///   const PatientForm(super.formViewModel, {super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     return Form(
///       key: formViewModel.formState,
///       child: Column(
///         children: [
///           TextFormField(
///             controller: formViewModel.nameController,
///             validator: (value) => FormValidators.validateNoEmpty(value, 'el nombre'),
///           ),
///           ElevatedButton(
///             onPressed: () {
///               final patient = formViewModel.mapDataToEntity();
///               if (patient != null) {
///                 // Hacer algo con la entidad validada
///                 Navigator.pop(context, patient);
///               }
///             },
///             child: Text('Guardar'),
///           ),
///         ],
///       ),
///     );
///   }
/// }
/// ```
///
/// Ejemplo con CRUD (opcional):
/// ```dart
/// class PatientFormWithCrud extends DefaultEntityForm<Patient, PatientFormViewModel> {
///   final PatientCrudViewModel crudViewModel;
///
///   const PatientFormWithCrud({
///     required PatientFormViewModel formViewModel,
///     required this.crudViewModel,
///     super.key,
///   }) : super(formViewModel);
///
///   @override
///   Widget build(BuildContext context) {
///     return Form(
///       key: formViewModel.formState,
///       child: Column(
///         children: [
///           TextFormField(
///             controller: formViewModel.nameController,
///             validator: (value) => FormValidators.validateNoEmpty(value, 'el nombre'),
///           ),
///           ElevatedButton(
///             onPressed: () async {
///               final patient = formViewModel.mapDataToEntity();
///               if (patient != null) {
///                 final result = await crudViewModel.addEntity(patient);
///                 if (result.isSuccess) formViewModel.clearFormData();
///               }
///             },
///             child: Text('Guardar'),
///           ),
///         ],
///       ),
///     );
///   }
/// }
/// ```
abstract class DefaultEntityForm<
  T extends Entity,
  VM extends EntityFormViewModel<T>
>
    extends StatelessWidget {
  const DefaultEntityForm(this.formViewModel, {super.key});

  /// ViewModel del formulario, encargado de campos y transformación de datos
  final VM formViewModel;
}
