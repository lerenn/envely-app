import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Envely/blocs/blocs.dart';
import 'package:Envely/models/models.dart';

import '../widgets/widgets.dart';

class AccountAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        appBar: AppBar(title: Text("Add Account")),
        body: SafeArea(child: SingleChildScrollView(child: _AccountAddForm())));
  }
}

class _AccountAddForm extends StatefulWidget {
  @override
  _AccountAddFormState createState() => _AccountAddFormState();
}

class _AccountAddFormState extends State<_AccountAddForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _typeController = AccountTypeFieldController();

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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  AccountNameField(controller: _nameController),
                  AccountTypeField(controller: _typeController),
                  addButton(state)
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              )));
    }));
  }

  Widget addButton(AccountsState state) {
    _onAccountAddButtonPressed() {
      if (_key.currentState.validate()) {
        final account = Account(
            id: "unknown",
            name: _nameController.text,
            type: _typeController.type);
        BlocProvider.of<AccountsBloc>(context)
            .add(AccountCreated(BudgetControllerSingleton().budget, account));
      }
    }

    return RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).colorScheme.onPrimary,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)),
      child: Text('Add account'),
      onPressed: state is AccountsLoading ? () {} : _onAccountAddButtonPressed,
    );
  }
}
