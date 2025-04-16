
import 'package:base_project/commans/widgets/custom_textform_field.dart';
import 'package:base_project/commans/widgets/custome_elevated_button.dart';
import 'package:base_project/resources/app_colors.dart';
import 'package:base_project/utils/managers/user_manager.dart';
import 'package:base_project/utils/validator/text_feild_validator.dart';
import 'package:base_project/view_model/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final ValueNotifier<bool> _obscureTextCurrentPass = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obscureTextNewPass = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obscureTextConfirmPass = ValueNotifier<bool>(true);

  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.adaptive.arrow_back,
            color: AppColors.textWhite,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: const Text(
          'Change Password',
          
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Current Password Field
              ValueListenableBuilder(
                valueListenable: _obscureTextCurrentPass,
                builder: (context, value, child) {
                  return MyCustomTextFormField(
                    validator: TextFieldValidator.validatePassword,
                    label: 'Current Password',

                    prefixIcon: const Icon(Icons.lock_outlined),
                    obscureText: _obscureTextCurrentPass.value,
                    controller: _currentPassController,
                     suffixIcon: IconButton(  // Make the suffix icon clickable
        icon: Icon(
          _obscureTextNewPass.value
              ? Icons.visibility_off
              : Icons.visibility,
        ),
        onPressed: () {
          // Toggle password visibility
          _obscureTextCurrentPass.value = !_obscureTextCurrentPass.value;
        },
      ),
                  );
                },
              ),
              const SizedBox(height: 20),

ValueListenableBuilder(
  valueListenable: _obscureTextNewPass,
  builder: (context, value, child) {
    return MyCustomTextFormField(
      validator: TextFieldValidator.validatePassword,
      label: 'New Password',
      prefixIcon: const Icon(Icons.lock_outlined),
      obscureText: _obscureTextNewPass.value,  // Controls visibility of text
      controller: _newPassController,
      suffixIcon: IconButton(  // Make the suffix icon clickable
        icon: Icon(
          _obscureTextNewPass.value
              ? Icons.visibility_off
              : Icons.visibility,
        ),
        onPressed: () {
          // Toggle password visibility
          _obscureTextNewPass.value = !_obscureTextNewPass.value;
        },
      ),
    );
  },
),

              const SizedBox(height: 20),

              // Confirm Password Field
              ValueListenableBuilder(
                valueListenable: _obscureTextConfirmPass,
                builder: (context, value, child) {
                  return MyCustomTextFormField(
                    validator: (value) {
                      return TextFieldValidator.validateConfirmPassword(
                          value, _newPassController.text);
                    },
                    label: 'Confirm Password',
                    
                    prefixIcon: const Icon(Icons.lock_outlined),
                    obscureText: _obscureTextConfirmPass.value,
                    controller: _confirmPassController,
suffixIcon: IconButton(  // Make the suffix icon clickable
        icon: Icon(
          _obscureTextNewPass.value
              ? Icons.visibility_off
              : Icons.visibility,
        ),
        onPressed: () {
          // Toggle password visibility
          _obscureTextConfirmPass.value = !_obscureTextConfirmPass.value;
        },
      ),
                  );
                },
              ),
              const SizedBox(height: 40),

              // Submit Button
              Consumer<ProfileViewModel>(
                builder: (context, provider, _) {
                return  Center(
                  child: MyCustomElevatedButton(
                    isLoading: provider.isUpdating,
                    child: const Text("Change Password"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final uId = UserManager().userId;
              
                        final data ={
                          "userId":uId,
                          "oldPassword": _currentPassController.text,
                          "newPassword": _newPassController.text,
                          "confirmPassword": _confirmPassController.text,
                        };
                        print(data);
                       provider.changePassword(data);
                      }
                    },
                  ),
                );
              },)

            ],
          ),
        ),
      ),
    );
  }
}
