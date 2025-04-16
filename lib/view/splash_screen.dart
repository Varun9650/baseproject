import 'dart:io';

import 'package:base_project/view_model/splash_view_model.dart';
import 'package:base_project/view_model/system_params/system_params_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashViewModel().checkNavigation(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<SystemParamsViewModel>(
                builder: (context, provider, _) {
                  print(provider.profileImg);
                  return provider.profileImg != null
                      ? Image.file(File(provider.profileImg!.path))
                      : Container();
                },
              ),
              const Text(
                "Splash Screen",
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
