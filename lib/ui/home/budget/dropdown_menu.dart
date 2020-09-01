import 'package:Envely/blocs/budgets/budgets_bloc.dart';
import 'package:Envely/blocs/budgets/budgets_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:progress_indicators/progress_indicators.dart';

import 'package:Envely/blocs/blocs.dart';
import 'package:Envely/models/models.dart';

class BudgetDropdownMenu extends StatelessWidget {
  final BudgetController controller;

  BudgetDropdownMenu({@required this.controller});

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
  final BudgetController controller;
  final List<Budget> budgets;

  BudgetDropdownMenuLoaded({@required this.controller, @required this.budgets});

  @override
  BudgetDropdownMenuLoadedState createState() =>
      BudgetDropdownMenuLoadedState();
}

class BudgetDropdownMenuLoadedState extends State<BudgetDropdownMenuLoaded> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      dropDown(context),
    ]);
  }

  Widget dropDown(BuildContext context) {
    if (widget.controller.budget == null ||
        !widget.budgets.contains(widget.controller.budget))
      widget.controller.set(context, widget.budgets[0]);

    return DropdownButton<Budget>(
      dropdownColor: Theme.of(context).primaryColor,
      value: widget.controller.budget,
      icon: Container(
          margin: EdgeInsets.only(left: 10), child: Icon(Icons.swap_vert)),
      iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
      items: widget.budgets.map((Budget value) {
        return DropdownMenuItem<Budget>(
            value: value,
            child: Container(
              width: ScreenUtil().setWidth(400),
              child: new Text(
                value.name,
                textAlign: TextAlign.end,
              ),
            ));
      }).toList(),
      style: TextStyle(
          fontSize: 20, color: Theme.of(context).colorScheme.onSecondary),
      onChanged: (Budget newValue) {
        setState(() {
          widget.controller.set(context, newValue);
        });
      },
      underline: Container(height: 0),
    );
  }
}

class BudgetController {
  Budget _budget;

  Budget get budget {
    return _budget;
  }

  void set(BuildContext context, Budget budget) {
    // Set budget
    _budget = budget;

    // Change blocs

    BlocProvider.of<AccountsBloc>(context).add(AccountsLoad(budget));
  }
}
