import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:progress_indicators/progress_indicators.dart';

import 'package:Envely/blocs/blocs.dart';
import 'package:Envely/models/models.dart';

import 'package:Envely/view/pages/budget_add_page.dart';

import 'budgets.dart';

class BudgetDropdownMenu extends StatelessWidget {
  final BudgetControllerSingleton controller = BudgetControllerSingleton();

  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return BlocListener<BudgetsBloc, BudgetsState>(listener: (context, state) {
      if (state is BudgetsLoadFailure) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
          backgroundColor: Theme.of(context).errorColor,
        ));
      }
    }, child: BlocBuilder<BudgetsBloc, BudgetsState>(builder: (context, state) {
      if (state is BudgetsLoadSuccess)
        return BudgetDropdownMenuLoaded(
            controller: controller, budgets: state.budgets);
      if (state is BudgetsLoadFailure)
        return BudgetDropdownMenuLoadFailed(message: state.error);
      return BudgetDropdownMenuLoading();
    }));
  }
}

class BudgetDropdownMenuLoadFailed extends StatelessWidget {
  final String message;

  BudgetDropdownMenuLoadFailed({@required this.message});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        color: Colors.white,
        textColor: Theme.of(context).primaryColor,
        child: Text('Retry Budget Loading'),
        onPressed: () {
          BlocProvider.of<BudgetsBloc>(context).add(BudgetsLoad());
        });
  }
}

class BudgetDropdownMenuLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return JumpingDotsProgressIndicator(
        color: Theme.of(context).colorScheme.onPrimary, fontSize: 20.0);
  }
}

class BudgetDropdownMenuLoaded extends StatefulWidget {
  final BudgetControllerSingleton controller;
  final List<Budget> budgets;

  BudgetDropdownMenuLoaded({@required this.controller, @required this.budgets});

  @override
  BudgetDropdownMenuLoadedState createState() =>
      BudgetDropdownMenuLoadedState();
}

class BudgetDropdownMenuLoadedState extends State<BudgetDropdownMenuLoaded> {
  @override
  Widget build(BuildContext context) {
    return displayMenu(context);
  }

  Widget displayMenu(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.layers_rounded),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Budgets"), content: contentMenu(context));
              });
        });
  }

  Widget contentMenu(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.budgets.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index < widget.budgets.length)
              return ListTile(
                  title: Text(widget.budgets[index].name),
                  onTap: () => {changeBudget(context, widget.budgets[index])});
            else
              return ListTile(
                  title: Row(children: [
                    Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Icon(Icons.add)),
                    Text("Add Budget")
                  ]),
                  onTap: () => {addBudget(context)});
          },
        ),
      )
    ]);
  }

  void changeBudget(BuildContext context, Budget budget) {
    Navigator.pop(context);
    widget.controller.set(context, budget);
  }

  void addBudget(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBudgetPage(),
      ),
    );
  }
}
