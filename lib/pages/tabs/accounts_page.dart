import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Envely/blocs/blocs.dart';
import 'package:Envely/models/models.dart';
import 'package:Envely/pages/common/common.dart';
import 'package:Envely/repositories/repositories.dart';

class AccountsTab extends StatefulWidget {
  @override
  _AccountsTabState createState() => _AccountsTabState();
}

class _AccountsTabState extends State<AccountsTab> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        body: SafeArea(
            child: BlocProvider<AccountsBloc>(
      create: (context) => AccountsBloc(
          accountsRepository:
              RepositoryProvider.of<AccountsRepository>(context))
        ..add(AccountsLoad()),
      child: page(context),
    )));
  }

  Widget page(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(builder: (context, state) {
      if (state is AccountsLoadSuccess)
        return Column(children: <Widget>[
          listAccounts(context, state.accounts),
          addAccount(context)
        ]);
      if (state is AccountsLoadFailure)
        return _AccountsLoadFailure(message: state.error);
      return Loading(false);
    });
  }

  Widget listAccounts(BuildContext context, List<Account> accounts) {
    return Expanded(
        child: ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (BuildContext context, int index) {
              final account = accounts[index];
              return ListTile(title: Text(account.name));
            }));
  }

  Widget addAccount(BuildContext context) {
    return FlatButton(
        onPressed: () {
          /*...*/
        },
        textColor: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(horizontal: 6),
                child: Icon(Icons.add_box)),
            Text("Add Account", style: TextStyle(fontSize: 18))
          ],
        ));
  }
}

class _AccountsLoadFailure extends StatelessWidget {
  final String message;

  _AccountsLoadFailure({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RichText(
            text: TextSpan(
                text: message,
                style: TextStyle(color: Theme.of(context).hintColor))),
        FlatButton(
            color: Colors.white,
            textColor: Theme.of(context).secondaryHeaderColor,
            child: Text('Retry'),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(AppLoaded());
            })
      ],
    ));
  }
}
