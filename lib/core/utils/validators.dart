abstract class Validators {
  static String? phone(String? value) {
    final phone = value?.trim() ?? '';
    if (phone.isEmpty) return 'Please enter your phone number';
    if (!RegExp(r'^09\d{8}$').hasMatch(phone)) {
      return 'Phone number must start with 09 and be 10 digits';
    }
    return null;
  }

  static String? name(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'Please enter your name';
    if (name.length < 3) return 'Name must be at least 3 characters';
    return null;
  }

  static String? email(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? otp(String? value, {int length = 5}) {
    final code = value?.trim() ?? '';
    if (code.isEmpty) return 'Please enter the code';
    if (code.length != length) return 'Code must be $length digits';
    return null;
  }

  static String? required(String? value, {String field = 'This field'}) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    return null;
  }
}