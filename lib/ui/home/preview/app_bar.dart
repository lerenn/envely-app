import 'package:flutter/material.dart';

import '../budget/budget.dart';

class PreviewAppBarBuilder {
  final BudgetController budgetController;

  PreviewAppBarBuilder(this.budgetController);

  AppBar build(BuildContext context) {
    return AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Text("Preview"),
          BudgetDropdownMenu(controller: budgetController)
        ]));
  }
}
