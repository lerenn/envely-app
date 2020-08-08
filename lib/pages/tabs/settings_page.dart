import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Envely/blocs/authentication/authentication.dart';
import 'package:Envely/models/models.dart';

class SettingsTab extends StatefulWidget {
  final User user;

  const SettingsTab({Key key, this.user}) : super(key: key);

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(
            '${widget.user.name}',
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
