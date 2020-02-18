class Validator {
  static String validateEmail(String value) {
    if (value == null || !value.contains((".")) || !value.contains("@")) {
      return "Enter a valid email address";
    }
    return null;
  }

  static String validatePassword(String value) {
    if (value == null) {
      return "Enter a valid password";
    } else if (value.length < 6)
      return "Password length must be 6 characters or more";
    return null;
  }
}
