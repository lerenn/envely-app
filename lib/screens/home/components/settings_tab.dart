import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Envely/blocs/blocs.dart';
import 'package:Envely/components/components.dart';
import 'package:Envely/models/models.dart';
import 'package:Envely/screens/screens.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key key}) : super(key: key);

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
      if (state is AuthenticationNotAuthenticated)
        Navigator.pushNamed(context, LoginPage.routeName);
    }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
      if (state is AuthenticationAuthenticated)
        return displaySettings(context, state.user);
      return Loading(true);
    }));
  }

  Widget displaySettings(BuildContext context, User user) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(
            '${user.name}',
            style: TextStyle(fontSize: 20),
          ),
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Disconnect'),
          onTap: () {
            // Add UserLoggedOut to authentication event stream.
            BlocProvider.of<AuthenticationBloc>(context).add(UserLoggedOut());
          },
        ),
      ],
    );
  }
}
