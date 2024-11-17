class ValidationService {
  static bool _isValidEmail(String string) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(string);
  }

  static bool _isValidPassword(String string) {
    final passwordRegExp =
        RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*\W)^.+$");
    return passwordRegExp.hasMatch(string);
  }

  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_isValidEmail(email)) {
      return 'Email has invalid pattern';
    }
    return null;
  }

  static String? validatePassword(String password, bool? checkPattern) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    } else if (password.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (checkPattern != null && !_isValidPassword(password)) {
      return 'Password doesn\'t match the pattern';
    }
    return null;
  }

  static String? validateFirstName(String firstName) {
    if (firstName.isEmpty) {
      return 'Name cannot be empty';
    } else {
      return null;
    }
  }

  static String? validateLastName(String lastName) {
    if (lastName.isEmpty) {
      return 'Last name is empty';
    } else {
      return null;
    }
  }

  static String? validateDescription(String description, int? maxLength) {
    if (description.isEmpty) {
      return 'Description cannot be empty';
    } else if (maxLength != null && description.length > maxLength) {
      return 'Description cannot be more than $maxLength characters';
    } else {
      return null;
    }
  }

  static String? validateLocation(String location) {
    if (location.isEmpty) {
      return 'Location cannot be empty';
    } else {
      return null;
    }
  }

  static validateInvitationCode(String invitationCode) {
    if (invitationCode.isEmpty) {
      return 'Invitation code cannot be empty';
    } else {
      return null;
    }
  }

  static validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return 'Phone number cannot be empty';
    } else {
      return null;
    }
  }

  static validateGuestsAmount(int guestsAmount) {
    switch (guestsAmount) {
      case < 1:
        return 'Guests amount cannot be less than 1';
      case > 20:
        return 'Guests amount cannot be more than 20';
      default:
        return null;
    }
  }
}
