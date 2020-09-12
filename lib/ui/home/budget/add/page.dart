import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Envely/blocs/budgets/budgets.dart';
import 'package:Envely/ui/common/common.dart';
import 'package:Envely/models/models.dart';

import '../common/common.dart';

class AddBudgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        appBar: AppBar(title: Text("Add Budget")),
        body: SafeArea(child: SingleChildScrollView(child: _AddBudgetForm())));
  }
}

class _AddBudgetForm extends StatefulWidget {
  @override
  _AddBudgetFormState createState() => _AddBudgetFormState();
}

class _AddBudgetFormState extends State<_AddBudgetForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _currencyController = BudgetCurrencyFieldController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BudgetsBloc, BudgetsState>(listener: (context, state) {
      if (state is BudgetCreatedFailure) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
          backgroundColor: Theme.of(context).errorColor,
        ));
      } else if (state is BudgetCreatedSuccess) {
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
              autovalidate: _autoValidate,
              child: Column(
                children: <Widget>[
                  BudgetNameField(controller: _nameController),
                  BudgetCurrencyField(controller: _currencyController),
                  addButton(state)
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              )));
    }));
  }

  Widget addButton(BudgetsState state) {
    _onAddBudgetButtonPressed() {
      if (_key.currentState.validate()) {
        final budget = Budget(
            id: "unknown",
            name: _nameController.text,
            currency: _currencyController.currency);
        BlocProvider.of<BudgetsBloc>(context).add(BudgetCreated(budget));
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).colorScheme.onPrimary,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)),
      child: Text('Add budget'),
      onPressed: state is BudgetsLoading ? () {} : _onAddBudgetButtonPressed,
    );
  }
}
