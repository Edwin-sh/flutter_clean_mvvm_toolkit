import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm_toolkit/src/presentation/viewmodels/base/default_form_view_model.dart';

/// Widget base abstracto para formularios de entidades
///
/// - [T]: Tipo de ViewModel que extiende DefaultFormViewModel
/// - Provee acceso al ViewModel y permite heredar lógica de presentación
/// - Úsalo como base para formularios CRUD en la capa de presentación
abstract class DefaultEntityForm<T extends DefaultFormViewModel>
    extends StatelessWidget {
  const DefaultEntityForm(this.formViewModel, {super.key});

  /// ViewModel del formulario, inyectado por el widget padre
  final T formViewModel;
}
