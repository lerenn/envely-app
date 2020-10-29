import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'envelops/envelops.dart';

class BudgetTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        body: SafeArea(
      child: Center(child: EnvelopsArea()),
    ));
  }
}

class EnvelopsArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BudgetList();
  }
}
