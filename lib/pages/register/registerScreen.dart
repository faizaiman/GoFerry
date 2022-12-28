import 'package:flutter/material.dart';
import 'package:goferry/pages/register/REGISTERFooterWidget.dart';
import 'package:goferry/pages/register/formHeaderWidget.dart';
import 'package:goferry/pages/register/registerFormWidget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: const [
                FormHeaderWidget(
                  image: 'assets/register.png',
                  subTitle: 'Create your profile to start journey',
                  title: 'Get On Board!',
                ),
                RegisterFormWidget(),
                RegisterFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
