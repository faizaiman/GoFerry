import 'package:flutter/material.dart';
import 'package:goferry/models/user.dart';
import 'package:goferry/services/ferryservice.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({Key? key, this.user}) : super(key: key);
  final User? user;
  @override
  _RegisterFormWidget createState() => _RegisterFormWidget();
}

class _RegisterFormWidget extends State<RegisterFormWidget> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobilePhoneController = TextEditingController();

  @override 
  void initState()
  {
    super.initState();
    if(widget.user != null)
    {
      _usernameController.text = widget.user!.username;
      _firstNameController.text = widget.user!.f_name;
      _lastNameController.text = widget.user!.l_name;
      _passwordController.text = widget.user!.password;
      _mobilePhoneController.text = widget.user!.mobilehp;
    }
  }

  Future<void> _onRegister() async
  {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final f_name = _firstNameController.text;
    final l_name = _lastNameController.text;
    final mobilehp = _mobilePhoneController.text;

    await _databaseService.registerUser(
      User(f_name: f_name, l_name: l_name, username: username, password: password, mobilehp: mobilehp)
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                  label: Text('First Name'),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                  label: Text('Last Name'),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                  label: Text('Username'),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                  label: Text('Password'), prefixIcon: Icon(Icons.fingerprint)),
            ),
            TextFormField(
              controller: _mobilePhoneController,
              decoration: const InputDecoration(
                  label: Text('Phone Number'),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onRegister,
                child: Text('REGISTER'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
