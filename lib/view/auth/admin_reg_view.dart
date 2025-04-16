import 'package:base_project/commans/widgets/custom_textform_field.dart';
import 'package:base_project/commans/widgets/custome_elevated_button.dart';
import 'package:base_project/resources/app_colors.dart';
import 'package:base_project/utils/validator/text_feild_validator.dart';
import 'package:base_project/view/auth/sign_up_view.dart';
import 'package:base_project/view_model/auth/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class AdminRegView extends StatelessWidget {
  AdminRegView({super.key});

  // Controllers and FormKey declarations
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _adminNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _workspaceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.adaptive.arrow_back)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              // Company Logo or Header
              const Center(
                child: Icon(
                  Icons.business_center_outlined,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),

              // Heading
              Text(
                "Register Your Company",
                textAlign: TextAlign.center,
                style: textTheme.headlineLarge!.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: size.height * 0.05),

              // Company Name
              MyCustomTextFormField(
                controller: _companyNameController,
                label: "Company Name",
                prefixIcon: const Icon(Icons.business),
                validator: TextFieldValidator.validateField,
              ),
              const SizedBox(height: 16),

              // Admin Full Name
              MyCustomTextFormField(
                controller: _adminNameController,
                label: "Admin Name",
                prefixIcon: const Icon(Iconsax.profile_circle),
                validator: TextFieldValidator.validateField,
              ),
              const SizedBox(height: 16),

              // Company Email
              MyCustomTextFormField(
                controller: _emailController,
                label: "Company Email",
                prefixIcon: const Icon(Icons.alternate_email),
                validator: TextFieldValidator.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Phone Number
              MyCustomTextFormField(
                controller: _phoneController,
                label: "Admin Phone Number",
                prefixIcon: const Icon(Icons.phone_outlined),
                validator: TextFieldValidator.validateField,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 16),

              // Workspace/Branch Name
              MyCustomTextFormField(
                controller: _workspaceController,
                label: "Workspace/Branch Name",
                prefixIcon: const Icon(Icons.location_city),
                validator: TextFieldValidator.validateField,
              ),

              const SizedBox(height: 30),

              // Sign Up Button
              Consumer<AuthViewModel>(
                builder: (context, provider, child) {
                  return MyCustomElevatedButton(
                    isLoading: provider.isLoading,
                    child: const Text("Register Company"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Collect all data here and pass to API or ViewModel
                        final Map<String, dynamic> signUpData = {
                          "companyName": _companyNameController.text,
                          "email": _emailController.text,
                          "mobile": _phoneController.text,
                          "workspace": _workspaceController.text,
                        };
                        provider.createAcc(context, signUpData);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpView(email: _emailController.text.toString()),
                            ));
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
