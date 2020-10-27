import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Envely/blocs/accounts/accounts.dart';
import 'package:Envely/ui/common/common.dart';
import 'package:Envely/models/models.dart';

import '../common/common.dart';

class EditAccountPage extends StatelessWidget {
  final Account account;

  EditAccountPage(this.account);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        appBar: AppBar(title: Text("Edit account")),
        body: SafeArea(
            child: SingleChildScrollView(child: _EditAccountForm(account))));
  }
}

class _EditAccountForm extends StatefulWidget {
  final Account account;

  _EditAccountForm(this.account);

  @override
  _EditAccountFormState createState() => _EditAccountFormState();
}

class _EditAccountFormState extends State<_EditAccountForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _typeController = AccountTypeFieldController();

  @override
  void initState() {
    _nameController.text = widget.account.name;
    if (widget.account.type != AccountType.Unknown)
      _typeController.type = widget.account.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountsBloc, AccountsState>(
        listener: (context, state) {
      if (state is AccountUpdatedFailure) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Update: " + state.error),
          backgroundColor: Theme.of(context).errorColor,
        ));
      } else if (state is AccountDeletedFailure) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Delete: " + state.error),
          backgroundColor: Theme.of(context).errorColor,
        ));
      } else if (state is AccountUpdatedSuccess ||
          state is AccountDeletedSuccess) {
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
                  AccountNameField(
                    controller: _nameController,
                  ),
                  AccountTypeField(controller: _typeController),
                  editButton(state),
                  deleteButton(state)
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              )));
    }));
  }

  Widget editButton(AccountsState state) {
    _onEditAccountButtonPressed() {
      if (_key.currentState.validate()) {
        var newModifiedAccount = Account(
            id: widget.account.id,
            name: _nameController.text,
            type: _typeController.type);

        // Check if the account has been modified
        if (newModifiedAccount != widget.account)
          BlocProvider.of<AccountsBloc>(context).add(AccountUpdated(
              BudgetControllerSingleton().budget, newModifiedAccount));
        else
          Navigator.pop(context);
      }
    }

    return RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).colorScheme.onPrimary,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)),
      child: Text('Update account'),
      onPressed: state is AccountsLoading ? () {} : _onEditAccountButtonPressed,
    );
  }

  Widget deleteButton(AccountsState state) {
    _onDeleteAccountButtonPressed() {
      if (_key.currentState.validate()) {
        BlocProvider.of<AccountsBloc>(context).add(
            AccountDeleted(BudgetControllerSingleton().budget, widget.account));
      }
    }

    return RaisedButton(
      color: Theme.of(context).errorColor,
      textColor: Theme.of(context).colorScheme.onPrimary,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)),
      child: Text('Delete account'),
      onPressed:
          state is AccountsLoading ? () {} : _onDeleteAccountButtonPressed,
    );
  }
}
