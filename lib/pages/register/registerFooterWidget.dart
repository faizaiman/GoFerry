import 'package:flutter/material.dart';
import 'package:goferry1/pages/login/loginScreen.dart';

class RegisterFooterWidget extends StatelessWidget {
  const RegisterFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: ('Already Have An Account? '),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TextSpan(text: ('Log In'))
          ])),
        )
      ],
    );
  }
}
