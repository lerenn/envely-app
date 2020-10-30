import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Envely/models/models.dart';
import 'package:Envely/blocs/blocs.dart';

import '../widgets/widgets.dart';

class BudgetEditPage extends StatelessWidget {
  final Budget budget;

  BudgetEditPage(this.budget);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        appBar: AppBar(title: Text("Edit budget")),
        body: SafeArea(
            child: SingleChildScrollView(child: _BudgetEditForm(budget))));
  }
}

class _BudgetEditForm extends StatefulWidget {
  final Budget budget;

  _BudgetEditForm(this.budget);

  @override
  _BudgetEditFormState createState() => _BudgetEditFormState();
}

class _BudgetEditFormState extends State<_BudgetEditForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _typeController = BudgetCurrencyFieldController();

  @override
  void initState() {
    _nameController.text = widget.budget.name;
    if (widget.budget.currency != Currency.Custom)
      _typeController.currency = widget.budget.currency;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BudgetsBloc, BudgetsState>(listener: (context, state) {
      if (state is BudgetUpdatedFailure) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Update: " + state.error),
          backgroundColor: Theme.of(context).errorColor,
        ));
      } else if (state is BudgetDeletedFailure) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Delete: " + state.error),
          backgroundColor: Theme.of(context).errorColor,
        ));
      } else if (state is BudgetUpdatedSuccess ||
          state is BudgetDeletedSuccess) {
        Navigator.pop(context);
      }
    }, child: BlocBuilder<BudgetsBloc, BudgetsState>(builder: (context, state) {
      if (state is BudgetsLoading) {
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
                  BudgetNameField(
                    controller: _nameController,
                  ),
                  BudgetCurrencyField(controller: _typeController),
                  editButton(state),
                  deleteButton(state)
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              )));
    }));
  }

  Widget editButton(BudgetsState state) {
    _onBudgetEditButtonPressed() {
      if (_key.currentState.validate()) {
        var newModifiedBudget = Budget(
            id: widget.budget.id,
            name: _nameController.text,
            currency: _typeController.currency);

        // Check if the budget has been modified
        if (newModifiedBudget != widget.budget)
          BlocProvider.of<BudgetsBloc>(context)
              .add(BudgetUpdated(newModifiedBudget));
        else
          Navigator.pop(context);
      }
    }

    return RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).colorScheme.onPrimary,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)),
      child: Text('Update budget'),
      onPressed: state is BudgetsLoading ? () {} : _onBudgetEditButtonPressed,
    );
  }

  Widget deleteButton(BudgetsState state) {
    _onDeleteBudgetButtonPressed() {
      if (_key.currentState.validate()) {
        BlocProvider.of<BudgetsBloc>(context).add(BudgetDeleted(widget.budget));
      }
    }

    return RaisedButton(
      color: Theme.of(context).errorColor,
      textColor: Theme.of(context).colorScheme.onPrimary,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)),
      child: Text('Delete budget'),
      onPressed: state is BudgetsLoading ? () {} : _onDeleteBudgetButtonPressed,
    );
  }
}
