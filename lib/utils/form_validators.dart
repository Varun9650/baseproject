class FormValidators {
  // Validator for non-empty fields
  static String? validateNotEmpty(String? value) {
    return value == null || value.isEmpty ? 'This field cannot be empty' : null;
  }

  // Validator for email format
  static String? validateEmail(String? value) {
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(emailPattern);
    return value == null || !regex.hasMatch(value) ? 'Enter a valid email address' : null;
  }

  // Validator for phone number format
  static String? validatePhoneNumber(String? value) {
    const phonePattern = r'^\+?[1-9]\d{1,14}$'; // E.164 format
    final regex = RegExp(phonePattern);
    return value == null || !regex.hasMatch(value) ? 'Enter a valid phone number' : null;
  }

  // Validator for min length
  static String? validateMinLength(String? value, int minLength) {
    return value == null || value.length < minLength ? 'Must be at least $minLength characters long' : null;
  }

  // Validator for max length
  static String? validateMaxLength(String? value, int maxLength) {
    return value != null && value.length > maxLength ? 'Must be no more than $maxLength characters long' : null;
  }

  // Validator for matching passwords
  static String? validatePasswordMatch(String? value, String password) {
    return value != password ? 'Passwords do not match' : null;
  }
}
