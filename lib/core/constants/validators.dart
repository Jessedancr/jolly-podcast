class Validators {
  // * Validate phone number
  static String? Function(String?) validatePhone() {
    return (String? value) {
      if (value!.isEmpty) {
        return 'Enter a valid phone number';
      }
      if (value.length != 11) {
        return 'Not a valid phone number.';
      }
      return null;
    };
  }
}
