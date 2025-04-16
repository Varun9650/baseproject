import 'package:base_project/commans/widgets/custom_textform_field.dart';
import 'package:base_project/commans/widgets/custome_elevated_button.dart';
import 'package:base_project/view_model/auth/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetOtpView extends StatelessWidget {
  GetOtpView({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.adaptive.arrow_back),
        ),
        title: const Text("Get Otp"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Enter an email to get otp"),
              const SizedBox(
                height: 20,
              ),
              MyCustomTextFormField(
                  prefixIcon: const Icon(Icons.mail),
                  label: "Email",
                  controller: _emailController),
              const SizedBox(
                height: 20,
              ),
              Consumer<AuthViewModel>(
                builder: (context, provider, child) {
                  return MyCustomElevatedButton(
                    isLoading: provider.isLoading,
                    child: const Text("Send Otp"),
                    onPressed: () {
                      final data = {
                        'emial': _emailController.text.trim().toString()
                      };
                      provider.getOtp(context, data);
                      
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
