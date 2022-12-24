import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goferry1/pages/login/loginFooterWidget.dart';
import 'package:goferry1/pages/login/loginFormWidget.dart';
import 'package:goferry1/pages/login/loginHeaderWidget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get the size in LoginHeaderWidget()
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LoginHeaderWidget(),
                LoginForm(),
                LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
