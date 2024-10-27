abstract interface class FirebaseAuthExceptions implements Exception {
  final String message;
  const FirebaseAuthExceptions([
    this.message = 'Error occured FirebaseAuthException',
  ]);
}

class FirebaseLoginException implements FirebaseAuthExceptions {
  final String errorMessage;

  FirebaseLoginException({required this.errorMessage});
  @override
  String get message => errorMessage;
}

class FirebaseSignupException implements FirebaseAuthExceptions {
  final String errorMessage;

  FirebaseSignupException({required this.errorMessage});
  @override
  String get message => errorMessage;
}
