import 'package:flutter/material.dart';
import 'package:goferry/pages/login/loginScreen.dart';
import 'package:goferry/pages/register/registerScreen.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
        ),
        const SizedBox(height: 0),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterScreen()));
          },
          child: Text.rich(
            TextSpan(
                text: ("Don't Have an Account? "),
                style: Theme.of(context).textTheme.bodyText1,
                children: const [
                  TextSpan(
                      text: 'Register', style: TextStyle(color: Colors.blue))
                ]),
          ),
        ),
      ],
    );
  }
}
