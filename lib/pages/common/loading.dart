import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final bool reversedColor;

  Loading(this.reversedColor);

  @override
  Widget build(BuildContext context) {
    var color = reversedColor
        ? Theme.of(context).primaryColor
        : Theme.of(context).secondaryHeaderColor;

    return Center(
        child: CircularProgressIndicator(
      backgroundColor: color,
      strokeWidth: 2,
    ));
  }
}
