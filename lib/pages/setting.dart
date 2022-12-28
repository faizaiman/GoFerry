import 'package:flutter/material.dart';
import 'package:goferry/models/user.dart';
import 'package:goferry/pages/login/loginScreen.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;
  @override
  State<SettingPage> createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16 * 2),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 16 * 2),
              const CircleAvatar(
                backgroundImage: AssetImage("assets/avatar.png"),
                radius: 100,
              ),
              const SizedBox(height: 16 * 2),
              Text(
                "Username: " + widget.user.username,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16 * 2),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text("Log Out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
