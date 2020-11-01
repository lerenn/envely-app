import 'package:flutter/material.dart';

import 'package:Envely/components/components.dart';

class SpendingsAppBarBuilder {
  AppBar build(BuildContext context) {
    return AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Spendings"), BudgetSwitcher()]));
  }
}
