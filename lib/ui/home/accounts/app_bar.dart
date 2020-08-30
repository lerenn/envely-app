import 'package:flutter/material.dart';

import '../budget/budget.dart';

class AccountsAppBarBuilder {
  final BudgetController budgetController;

  AccountsAppBarBuilder(this.budgetController);

  AppBar build(BuildContext context) {
    return AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Text("Accounts"),
          BudgetDropdownMenu(controller: budgetController)
        ]));
  }
}
