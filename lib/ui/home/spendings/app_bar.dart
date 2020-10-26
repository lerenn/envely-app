import 'package:flutter/material.dart';

import 'package:Envely/ui/common/common.dart';

class SpendingsAppBarBuilder {
  AppBar build(BuildContext context) {
    return AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Spendings"), BudgetDropdownMenu()]));
  }
}
