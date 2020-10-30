import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Envely/models/models.dart';
import 'package:Envely/blocs/blocs.dart';

import '../widgets/widgets.dart';

class BudgetAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        appBar: AppBar(title: Text("Add Budget")),
        body: SafeArea(child: SingleChildScrollView(child: _BudgetAddForm())));
  }
}

class _BudgetAddForm extends StatefulWidget {
  @override
  _BudgetAddFormState createState() => _BudgetAddFormState();
}

class _BudgetAddFormState extends State<_BudgetAddForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _currencyController = BudgetCurrencyFieldController();

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
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
    _onBudgetAddButtonPressed() {
      if (_key.currentState.validate()) {
        final budget = Budget(
            id: "unknown",
            name: _nameController.text,
            currency: _currencyController.currency);
        BlocProvider.of<BudgetsBloc>(context).add(BudgetCreated(budget));
      }
    }

    return RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).colorScheme.onPrimary,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)),
      child: Text('Add budget'),
      onPressed: state is BudgetsLoading ? () {} : _onBudgetAddButtonPressed,
    );
  }
}
