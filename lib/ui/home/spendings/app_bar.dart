import 'package:flutter/material.dart';

import '../budget/budget.dart';

class SpendingsAppBarBuilder {
  final BudgetController budgetController;

  SpendingsAppBarBuilder(this.budgetController);

  AppBar build(BuildContext context) {
    return AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Text("Spendings"),
          BudgetDropdownMenu(controller: budgetController)
        ]));
  }
}
