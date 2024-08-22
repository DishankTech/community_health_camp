class Validators {
  bool isValidEmail(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  static bool isValidMobileNo(String str) {
    final bool mobileValid = RegExp(r"^(0/91)?[6-9][0-9]{9}").hasMatch(str);
    return mobileValid;
  }

  static isPANValid(String pan) {
    return RegExp(r"[A-Z]{5}[0-9]{4}[A-Z]{1}").hasMatch(pan);
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    if (!isValidMobileNo(value)) {
      return 'Please enter a valid 10-digit Indian mobile number';
    }
    return null; // Validation passed
  }
}
