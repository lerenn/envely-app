import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreviewTab extends StatefulWidget {
  @override
  _PreviewTabState createState() => _PreviewTabState();
}

class _PreviewTabState extends State<PreviewTab> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        body: SafeArea(
      child: Center(child: Text("Preview")),
    ));
  }
}
