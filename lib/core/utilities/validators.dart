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
    // (0/91): number starts with (0/91)
    // [7-9]: starting of the number may contain a digit between 0 to 9
    // [0-9]: then contains digits 0 to 9
    // Pattern ptrn = Pattern.compile("(0/91)?[7-9][0-9]{9}");
    // the matcher() method creates a matcher that will match the given input
    // against this pattern
    // Matcher match = ptrn.matcher(str);
    // returns a boolean value
    // return (match.find() && match.group().equals(str));
  }

  static isPANValid(String pan) {
    return RegExp(r"[A-Z]{5}[0-9]{4}[A-Z]{1}").hasMatch(pan);
  }
}
