import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Envely/blocs/authentication/authentication.dart';
import 'package:Envely/models/models.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Container(
                  color: Theme.of(context).primaryColor,
                  child: SafeArea(
                      child: TabBar(
                          indicatorColor:
                              Theme.of(context).secondaryHeaderColor,
                          tabs: [
                        Tab(icon: Icon(Icons.assistant)),
                        Tab(icon: Icon(Icons.pie_chart)),
                        Tab(icon: Icon(Icons.account_balance_wallet)),
                        Tab(icon: Icon(Icons.account_circle)),
                      ])))),
          body: TabBarView(
            children: [
              Icon(Icons.assistant),
              Icon(Icons.pie_chart),
              Icon(Icons.account_balance_wallet),
              Account(user: widget.user),
            ],
          ),
        ));
  }
}

class Account extends StatefulWidget {
  final User user;

  const Account({Key key, this.user}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Welcome, ${widget.user.name}',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 12,
        ),
        FlatButton(
          textColor: Theme.of(context).primaryColor,
          child: Text('Logout'),
          onPressed: () {
            // Add UserLoggedOut to authentication event stream.
            BlocProvider.of<AuthenticationBloc>(context).add(UserLoggedOut());
          },
        )
      ],
    );
  }
}

// class HomePage extends StatelessWidget {
//   final User user;

//   const HomePage({Key key, this.user}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         minimum: const EdgeInsets.all(16),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Welcome, ${user.name}',
//                 style: TextStyle(fontSize: 24),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               FlatButton(
//                 textColor: Theme.of(context).primaryColor,
//                 child: Text('Logout'),
//                 onPressed: () {
//                   // Add UserLoggedOut to authentication event stream.
//                   BlocProvider.of<AuthenticationBloc>(context)
//                       .add(UserLoggedOut());
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
