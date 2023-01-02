import 'package:flutter/material.dart';
import 'package:goferry/models/user.dart';
import 'package:goferry/pages/register/registerFormWidget.dart';
import 'package:goferry/services/ferryservice.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: ('Username'),
                  hintText: ('Username'),
                  border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username.';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username.';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: ('Password'),
                hintText: ('Password'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    User user = User(
                        username: usernameController.text,
                        password: passwordController.text);
                    _databaseService.userLogin(user, context);
                  }
                },
                child: Text('LOG IN'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
