import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpendingsTab extends StatefulWidget {
  @override
  _SpendingsTabState createState() => _SpendingsTabState();
}

class _SpendingsTabState extends State<SpendingsTab> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        body: SafeArea(
      child: Center(child: Text("Spendings")),
    ));
  }
}
