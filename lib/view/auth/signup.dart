import 'package:flutter/material.dart';

class SignupView extends StatelessWidget {
  const SignupView
({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.adaptive.arrow_back),
        ),
        title: const Text("SignUp"),
      ),
    );
  }
}