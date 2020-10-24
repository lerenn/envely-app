class EnvelopsException implements Exception {
  final String message;

  EnvelopsException({this.message = 'Unknown error occurred. '});

  @override
  String toString() {
    return 'EnvelopsException: $message';
  }
}
