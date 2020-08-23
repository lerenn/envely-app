class BudgetsException implements Exception {
  final String message;

  BudgetsException({this.message = 'Unknown error occurred. '});

  @override
  String toString() {
    return 'BudgetsException: $message';
  }
}
