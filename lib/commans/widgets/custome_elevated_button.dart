import 'package:base_project/resources/app_colors.dart';
import 'package:flutter/material.dart';

class MyCustomElevatedButton extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final bool isLoading;
  final VoidCallback onPressed;

  const MyCustomElevatedButton({
    super.key,
     this.backgroundColor = AppColors.primary,
    required this.child,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.infinity, 50), // Full width, height of 50
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0, // Adjust thickness if needed
              ),
            )
          : child,
    );
  }
}
