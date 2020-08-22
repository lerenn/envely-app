import 'package:Envely/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Envely/blocs/accounts/accounts.dart';
import 'package:Envely/ui/common/common.dart';
import 'package:Envely/models/models.dart';

class AddAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        appBar: AppBar(title: Text("Add Account")),
        body: addWithAccountsBloc(context));
    // body: _AddAccountForm());
  }

  BlocProvider addWithAccountsBloc(BuildContext context) {
    return BlocProvider<AccountsBloc>(
      create: (context) => AccountsBloc(
          accountsRepository:
              RepositoryProvider.of<AccountsRepository>(context)),
      child: _AddAccountForm(),
    );
  }
}

class _AddAccountForm extends StatefulWidget {
  @override
  _AddAccountFormState createState() => _AddAccountFormState();
}

class _AddAccountFormState extends State<_AddAccountForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  AccountType type = AccountType.CreditCard;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountsBloc, AccountsState>(
        listener: (context, state) {
      if (state is AccountCreatedFailure) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
          backgroundColor: Theme.of(context).errorColor,
        ));
      } else if (state is AccountCreatedSuccess) {
        Navigator.pop(context);
      }
    }, child:
            BlocBuilder<AccountsBloc, AccountsState>(builder: (context, state) {
      if (state is AccountsLoading) {
        return Center(
          child: Container(
              margin: new EdgeInsets.all(100.0), child: Loading(true)),
        );
      }

      return Container(
          constraints: BoxConstraints(maxWidth: 400),
          margin: new EdgeInsets.all(25.0),
          width: ScreenUtil().setWidth(1080),
          child: Form(
              key: _key,
              autovalidate: _autoValidate,
              child: Column(
                children: <Widget>[
                  nameField(context),
                  typeField(context),
                  addButton(state)
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              )));
    }));
  }

  TextFormField nameField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Account name',
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        filled: true,
        isDense: true,
      ),
      style: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      controller: _nameController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      validator: (value) {
        if (value == null || value == "") {
          return 'Name is required.';
        }
        return null;
      },
    );
  }

  Widget typeField(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: DropdownButton<AccountType>(
          value: type,
          isExpanded: true,
          items: AccountType.values
              .where((value) => value != AccountType.Unknown)
              .map((AccountType value) {
            return DropdownMenuItem<AccountType>(
              value: value,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          text: value.name(),
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                    RichText(
                        text: TextSpan(
                      text: value.mode(),
                      style: TextStyle(color: Colors.grey),
                    )),
                  ]),
            );
          }).toList(),
          onChanged: (AccountType newValue) {
            setState(() {
              type = newValue;
            });
          },
          underline: Container(
            height: 0,
            color: Theme.of(context).primaryColor,
          ),
        ));
  }

  Widget addButton(AccountsState state) {
    _onSignInButtonPressed() {
      if (_key.currentState.validate()) {
        final account =
            Account(id: "unknown", name: _nameController.text, type: type);
        BlocProvider.of<AccountsBloc>(context).add(AccountCreated(account));
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return RaisedButton(
      color: Theme.of(context).secondaryHeaderColor,
      textColor: Theme.of(context).primaryColor,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)),
      child: Text('Add account'),
      onPressed: state is AccountsLoading ? () {} : _onSignInButtonPressed,
    );
  }
}
