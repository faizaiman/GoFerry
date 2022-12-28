import 'package:flutter/material.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            image: const AssetImage('assets/register.png'),
            height: size.height * 0.27),
        Text(
          'Welcome Back,',
          style: Theme.of(context).textTheme.headline4,
        ),
        Text('Travel fast with us',
            style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
