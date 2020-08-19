class AccountsException implements Exception {
  final String message;

  AccountsException({this.message = 'Unknown error occurred. '});

  @override
  String toString() {
    return 'AccountsException: $message';
  }
}
