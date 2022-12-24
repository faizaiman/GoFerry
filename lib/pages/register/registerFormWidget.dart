import 'package:flutter/material.dart';
import 'package:goferry/models/user.dart';
import 'package:goferry/services/ferryservice.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({Key? key, this.user}) : super(key: key);
  final User? user;
  @override
  _RegisterFormWidget createState() => _RegisterFormWidget();
}

class _RegisterFormWidget extends State<BrandFormPage> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  label: Text('First Name'),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text('Last Name'),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text('Username'),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text('Password'), prefixIcon: Icon(Icons.fingerprint)),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text('Phone Number'),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('REGISTER'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
