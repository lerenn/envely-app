import 'package:flutter/material.dart';

import 'package:Envely/ui/common/common.dart';

class PreviewAppBarBuilder {
  AppBar build(BuildContext context) {
    return AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Preview"), BudgetDropdownMenu()]));
  }
}
