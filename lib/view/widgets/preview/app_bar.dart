import 'package:flutter/material.dart';

import '../budgets/switcher.dart';

class PreviewAppBarBuilder {
  AppBar build(BuildContext context) {
    return AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Preview"), BudgetSwitcher()]));
  }
}
