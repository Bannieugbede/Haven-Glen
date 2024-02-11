class ZFirebaseAuthException implements Exception {
  //
  final String? code;

  //
  ZFirebaseAuthException(this.code);

  //
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'This email address is already registered';
      case 'invalid-email':
        return 'This email provider is invalid, please enter a valid email';
      case 'user-disabled':
        return 'This user account has been disabled';
      case 'user-not-found':
        return 'User detail, not found';
      case 'wrong-password':
        return 'Incorrect password, please check and retry';
      case 'email-already-exists':
        return 'This email address already exits';
      // case 'email-already-in-use':
      //   return '---------';
    }
    return '';
  }
}
