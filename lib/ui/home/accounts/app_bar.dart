import 'package:flutter/material.dart';

import 'package:Envely/ui/common/common.dart';

class AccountsAppBarBuilder {
  AppBar build(BuildContext context) {
    return AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Accounts"), BudgetDropdownMenu()]));
  }
}
