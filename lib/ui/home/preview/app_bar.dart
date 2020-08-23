import 'package:flutter/material.dart';

import '../budget/budget.dart';

class PreviewAppBarBuilder {
  final BudgetSelectionController budgetSelectionController;

  PreviewAppBarBuilder(this.budgetSelectionController);

  AppBar build(BuildContext context) {
    return AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Text("Preview"),
          BudgetDropdownMenu(controller: budgetSelectionController)
        ]));
  }
}
