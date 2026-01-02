

import 'package:dartz/dartz.dart' show Either, left, right;
import 'package:flutter/material.dart';
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

/// Simple use case that returns a greeting for the given name.
class GreetUserUseCase extends UseCase<String, String> {
  @override
  Future<Either<ErrorItem, String>> call(String params) async {


    if (params.isEmpty) {
      return left(
        ErrorItem(
          title: 'Invalid Name',
          message: 'Name cannot be empty',
          code: ErrorCode.validationError,
        ),
      );
    }
    return right('Hello, $params!');

  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean MVVM Toolkit Example',
      home: const ExamplePage(),
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final _controller = TextEditingController(text: 'Ada');
  final _greetUser = GreetUserUseCase();
  String _message = 'Tap the button to greet the user.';

  Future<void> _runUseCase() async {
    final either = await _greetUser(_controller.text);
    either.fold(
      (error) => setState(() => _message = 'Error: ${error.message}'),
      (greeting) => setState(() => _message = greeting),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toolkit Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This example uses the UseCase base class to generate a greeting.',
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _runUseCase, child: const Text('Greet')),
            const SizedBox(height: 24),
            Text(_message, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
