class TextFieldValidator {
  // Email validation using RegExp for strict validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Strict email pattern
    String pattern =
        r"^[a-zA-Z0-9]+([._-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]+([._-]?[a-zA-Z0-9]+)*\.[a-zA-Z]{2,7}$";
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  // Simple field validation (non-empty check)
  static String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // Password validation (simple length check, can be expanded for complexity)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Minimum 8 characters check
    // if (value.length < 8) {
    //   return 'Password must be at least 8 characters long';
    // }

    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }
}
