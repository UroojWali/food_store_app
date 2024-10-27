class AuthenticationException implements Exception {
  final String message;
  const AuthenticationException([
    this.message = 'Failed to authenticate user',
  ]) : super();
}
