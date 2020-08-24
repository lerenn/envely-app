import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final bool reversedColor;

  Loading(this.reversedColor);

  @override
  Widget build(BuildContext context) {
    var color = reversedColor
        ? Theme.of(context).backgroundColor
        : Theme.of(context).colorScheme.onBackground;

    return Center(
        child: CircularProgressIndicator(
      backgroundColor: color,
      strokeWidth: 2,
    ));
  }
}
