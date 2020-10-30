import 'package:flutter/material.dart';

import '../budgets/switcher.dart';

class AccountsAppBarBuilder {
  AppBar build(BuildContext context) {
    return AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Accounts"), BudgetSwitcher()]));
  }
}
