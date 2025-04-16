import 'package:base_project/commans/widgets/custom_textform_field.dart';
import 'package:base_project/commans/widgets/custome_elevated_button.dart';
import 'package:base_project/routes/route_names.dart';
import 'package:base_project/view_model/auth/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Define controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Define ValueNotifier for password visibility
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _isPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome message
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // App logo image
              Image.network(
                'https://via.placeholder.com/150', // Replace with your logo URL
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),

              // Email field
              MyCustomTextFormField(
                label: "Email",
                controller: emailController,
              ),

              const SizedBox(height: 16),

              // Password field
              ValueListenableBuilder<bool>(
                valueListenable: _isPasswordVisible,
                builder: (context, isPasswordVisible, child) {
                  return MyCustomTextFormField(
                    label: "Password",
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        _isPasswordVisible.value = !isPasswordVisible;
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Forgot password link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password action
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 20),

              // Login button
              Consumer<AuthViewModel>(
                builder: (context, provider, child) {
                  return MyCustomElevatedButton(
                    isLoading: provider.isLoading,
                    onPressed: () {
                      final data = {
                         "email" : emailController.text,
                         "password" : passwordController.text,
                       };
                       provider.login(context, data);


                    },
                    child: const Text('Login'),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Signup navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context,
                          RouteNames
                              .getOtpView); // Navigate to the signup screen
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
