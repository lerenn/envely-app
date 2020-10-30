class CategoriesException implements Exception {
  final String message;

  CategoriesException({this.message = 'Unknown error occurred. '});

  @override
  String toString() {
    return 'CategoriesException: $message';
  }
}
