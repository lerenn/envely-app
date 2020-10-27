enum Collections {
  Accounts,
  Budgets,
  Categories,
  Envelops,
}

extension CollectionsExtension on Collections {
  String get name {
    switch (this) {
      case Collections.Accounts:
        return 'accounts';
      case Collections.Budgets:
        return 'budgets';
      case Collections.Categories:
        return 'categories';
      case Collections.Envelops:
        return 'envelops';
      default:
        return 'unknown';
    }
  }
}
