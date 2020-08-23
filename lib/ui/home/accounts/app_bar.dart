import 'package:flutter/material.dart';

import '../budget/budget.dart';

class AccountsAppBarBuilder {
  final BudgetSelectionController budgetSelectionController;

  AccountsAppBarBuilder(this.budgetSelectionController);

  AppBar build(BuildContext context) {
    return AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Text("Accounts"),
          BudgetDropdownMenu(controller: budgetSelectionController)
        ]));
  }
}
