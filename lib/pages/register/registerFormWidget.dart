import 'package:flutter/material.dart';
import 'package:goferry/models/user.dart';
import 'package:goferry/services/ferryservice.dart';
import 'package:goferry/pages/displayFerry.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({Key? key}) : super(key: key);

  @override
  _RegisterFormWidget createState() => _RegisterFormWidget();
}

class _RegisterFormWidget extends State<RegisterFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobilePhoneController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                  label: Text('First Name'),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
              validator: (value)
              {
                if(value == null || value.isEmpty)
                {
                  return 'Please enter your first name.';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                  label: Text('Last Name'),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
              validator: (value)
              {
                if(value == null || value.isEmpty)
                {
                  return 'Please enter your last name.';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                  label: Text('Username'),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
              validator: (value)
              {
                if(value == null || value.isEmpty)
                {
                  return 'Please enter a username.';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                  label: Text('Password'), prefixIcon: Icon(Icons.fingerprint)),
              validator: (value)
              {
                if(value == null || value.isEmpty)
                {
                  return 'Please enter a password.';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: _mobilePhoneController,
              decoration: const InputDecoration(
                  label: Text('Phone Number'),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
              validator: (value)
              {
                if(value == null || value.isEmpty)
                {
                  return 'Please enter your phone number.';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()
                { 
                  if(_formKey.currentState!.validate())
                  {
                    User user = User
                    (
                      f_name: _firstNameController.text, 
                      l_name: _lastNameController.text, 
                      username: _usernameController.text, 
                      password: _passwordController.text, 
                      mobilehp: _mobilePhoneController.text,
                    );
                    _databaseService.registerUser(user, context);
                  }
                },
                child: Text('REGISTER'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
