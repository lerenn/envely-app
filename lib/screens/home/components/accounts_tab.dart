import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Envely/blocs/blocs.dart';
import 'package:Envely/models/models.dart';
import 'package:Envely/components/components.dart';
import 'package:Envely/screens/screens.dart';

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
      child: content(context),
    ));
  }

  Widget content(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(builder: (context, state) {
      if (state is AccountsLoadSuccess)
        return Column(children: <Widget>[
          _AccountsList(state.accounts),
          _AddAccountButton()
        ]);
      if (state is AccountsLoadFailure)
        return LoadFailure(
            message: state.error,
            bloc: BlocProvider.of<AccountsBloc>(context),
            reloadAction: AccountsLoad(BudgetControllerSingleton().budget));
      return Loading(false);
    });
  }
}

class _AccountsList extends StatelessWidget {
  final List<Account> accounts;

  _AccountsList(this.accounts);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (BuildContext context, int index) {
              final account = accounts[index];
              return ListTile(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                          text: TextSpan(
                        text: account.name,
                        style: TextStyle(color: Colors.black),
                      )),
                      Row(children: [
                        RichText(
                            text: TextSpan(
                          text: account.type.name(),
                          style: TextStyle(color: Colors.grey),
                        )),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Icon(Icons.arrow_right)),
                      ]),
                    ]),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AccountEditPage.routeName,
                    arguments: account,
                  );
                },
              );
            }));
  }
}

class _AddAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AccountAddPage.routeName,
          );
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
