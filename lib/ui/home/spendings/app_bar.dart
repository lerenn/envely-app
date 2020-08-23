import 'package:flutter/material.dart';

import '../budget/budget.dart';

class SpendingsAppBarBuilder {
  final BudgetSelectionController budgetSelectionController;

  SpendingsAppBarBuilder(this.budgetSelectionController);

  AppBar build(BuildContext context) {
    return AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Text("Spendings"),
          BudgetDropdownMenu(controller: budgetSelectionController)
        ]));
  }
}
