import 'package:flutter/material.dart';

import '../budget/budget.dart';

class BudgetAppBarBuilder {
  final BudgetSelectionController budgetSelectionController;

  BudgetAppBarBuilder(this.budgetSelectionController);

  AppBar build(BuildContext context) {
    return AppBar(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Budget"),
        Row(children: [
          BudgetDropdownMenu(controller: budgetSelectionController),
          Container(margin: EdgeInsets.only(left: 10)),
          _SettingsButton(),
        ]),
      ]),
      bottom: AppBar(
          toolbarHeight: 40,
          centerTitle: true,
          textTheme: TextTheme(
              headline6: TextStyle(color: Theme.of(context).primaryColor)),
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
            Text("Period"),
            Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor)
          ])),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    return Icon(Icons.settings);
  }
}
