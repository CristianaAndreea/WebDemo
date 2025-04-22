class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static bool isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.length >= 5 && password.length <= 40;
  }

  static bool isUsernameValid(String name) {
    return name.length >= 3 && name.length <= 100;
  }

  static String? validateNameError(
    String? name,
  ) {
    if (name == null || name.isEmpty) {
      return 'Name should not be empty';
    }
    return null;
  }
}
