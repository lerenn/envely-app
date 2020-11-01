import 'package:flutter/material.dart';

import 'package:Envely/components/components.dart';

class AccountsAppBarBuilder {
  AppBar build(BuildContext context) {
    return AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Accounts"), BudgetSwitcher()]));
  }
}
