import 'package:base_project/commans/widgets/custom_textform_field.dart';
import 'package:base_project/commans/widgets/custome_elevated_button.dart';
import 'package:base_project/resources/app_colors.dart';
import 'package:base_project/routes/route_names.dart';
import 'package:base_project/utils/validator/text_feild_validator.dart';
import 'package:base_project/view_model/auth/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  final String email;
  SignUpView({super.key, required this.email});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ValueNotifier<String?> _gender = ValueNotifier<String?>(null);
  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
    print("Email-$email");

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.loginView,
              (Route<dynamic> route) => false,
            );
          },
          icon: Icon(
            isIOS ? Icons.arrow_back_ios_new_rounded : Icons.arrow_back,
            color: AppColors.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Create an Account!",
                textAlign: TextAlign.center,
                style: textTheme.headlineLarge!.copyWith(fontSize: 32),
              ),
              const SizedBox(height: 8),
              Text(
                "Join us today, it's quick and easy.",
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.1),

              // First Name
              MyCustomTextFormField(
                controller: _firstNameController,
                label: "First Name",
                prefixIcon: const Icon(Icons.person),
                validator: TextFieldValidator.validateField,
              ),
              const SizedBox(height: 16),

              // Last Name
              MyCustomTextFormField(
                controller: _lastNameController,
                label: "Last Name",
                prefixIcon: const Icon(Iconsax.profile_circle),
                validator: TextFieldValidator.validateField,
              ),
              const SizedBox(height: 16),

              // Phone Number
              MyCustomTextFormField(
                controller: _phoneController,
                label: "Phone Number",
                prefixIcon: const Icon(Icons.phone_outlined),
                validator: TextFieldValidator.validateField,
                keyboardType: const TextInputType.numberWithOptions(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 16),

              // DOB Field
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  // Agar user cancel kare to default date set ho jaye
                  pickedDate ??= DateTime.now();
                  _dobController.text =
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                },
                child: AbsorbPointer(
                  child: MyCustomTextFormField(
                    controller: _dobController,
                    label: "Date of Birth",
                    prefixIcon: const Icon(Icons.cake_outlined),
                    validator: TextFieldValidator.validateField,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              ValueListenableBuilder(
                valueListenable: _obscureText,
                builder: (context, value, child) {
                  return MyCustomTextFormField(
                    controller: _passwordController,
                    label: "Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    obscureText: value,
                    validator: TextFieldValidator.validatePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        value ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        _obscureText.value = !value;
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Confirm Password Field
              ValueListenableBuilder(
                valueListenable: _obscureText,
                builder: (context, value, child) {
                  return MyCustomTextFormField(
                    controller: _confirmPasswordController,
                    label: "Confirm Password",
                    obscureText: value,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        value ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        _obscureText.value = !value;
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),

              // Sign Up Button
              Consumer<AuthViewModel>(
                builder: (context, provider, child) {
                  return MyCustomElevatedButton(
                    isLoading: provider.isLoading,
                    child: const Text("Sign Up"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final Map<String, dynamic> signUpData = {
                          "first_name": _firstNameController.text,
                          "last_name": _lastNameController.text,
                          "email": email,
                          "mob_no": _phoneController.text,
                          "date_of_birth": _dobController.text,
                          "new_password": _passwordController.text,
                          "confirm_password": _confirmPasswordController.text,
                          "usrGrpId": 1,
                        };

                        provider.signUp(context, signUpData);
                      }
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
