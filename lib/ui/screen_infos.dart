import 'package:flutter/widgets.dart';
import 'package:Envely/models/models.dart';

class ScreenInfosWidget extends StatelessWidget {
  final Widget Function(
      BuildContext context, ScreenInformations screenInformations) builder;
  const ScreenInfosWidget({Key key, this.builder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var infos = ScreenInformations(
      orientation: mediaQuery.orientation,
      screenSize: mediaQuery.size,
    );
    return builder(context, infos);
  }
}
