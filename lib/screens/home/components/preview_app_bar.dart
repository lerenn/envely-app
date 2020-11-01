import 'package:flutter/material.dart';

import 'package:Envely/components/components.dart';

class PreviewAppBarBuilder {
  AppBar build(BuildContext context) {
    return AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Preview"), BudgetSwitcher()]));
  }
}
