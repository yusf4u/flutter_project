class AuthValidators {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Username is required';
    if (value.length < 4) return 'Username must be at least 4 characters';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}