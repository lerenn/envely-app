class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});

  @override
  String toString() {
    return 'AuthenticationException: $message';
  }
}
