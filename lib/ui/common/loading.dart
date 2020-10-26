import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class LoadFailure extends StatelessWidget {
  final String message;
  final Bloc<dynamic, dynamic> bloc;
  final Object reloadAction;

  LoadFailure({
    @required this.message,
    @required this.bloc,
    @required this.reloadAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RichText(
            text: TextSpan(
                text: message,
                style: TextStyle(color: Theme.of(context).primaryColor))),
        FlatButton(
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).colorScheme.onPrimary,
            child: Text('Retry'),
            onPressed: () {
              bloc.add(reloadAction);
            })
      ],
    ));
  }
}
