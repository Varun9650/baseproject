import 'package:base_project/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyCustomTextFormField extends StatelessWidget {
  final String label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final bool? obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final void Function()? onSuffixIconPressed;
  

  const MyCustomTextFormField({
    super.key,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    
    this.initialValue,
    required this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1, this.obscureText, this.onSuffixIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      cursorColor: AppColors.primary,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.primary),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none, // No border
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
        // For rounded corners
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
