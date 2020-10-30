import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Envely/logic/blocs/blocs.dart';
import 'package:Envely/logic/models/models.dart';

import 'package:Envely/view/screens/budget_add_screen.dart';
import 'package:Envely/view/screens/budget_edit_screen.dart';

import '../budgets/controller.dart';
import '../budgets/switcher.dart';

class BudgetAppBarBuilder {
  AppBar build(BuildContext context) {
    return AppBar(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Budget"),
        Row(children: [
          _SettingsButton(),
          BudgetSwitcher(),
        ]),
      ]),
      bottom: AppBar(
          toolbarHeight: 40,
          centerTitle: true,
          textTheme: TextTheme(
              headline6: TextStyle(color: Theme.of(context).primaryColor)),
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
            Text("Period"),
            Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor)
          ])),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  final List<SettingsField> list = [
    SettingsFieldAdd(),
    SettingsFieldModify(),
    SettingsFieldDelete()
  ];

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Budgets"),
                    content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                    title: Row(children: [
                                      Container(
                                          margin: EdgeInsets.only(right: 20),
                                          child: Icon(list[index].iconData)),
                                      Text(list[index].name)
                                    ]),
                                    onTap: () => {
                                          list[index].onTap(
                                              context,
                                              BudgetControllerSingleton()
                                                  .budget)
                                        });
                              },
                            ),
                          )
                        ]));
              });
        });
  }
}

abstract class SettingsField {
  final _name = "";
  final _iconData = null;

  void onTap(BuildContext context, Budget budget);

  String get name {
    return _name;
  }

  IconData get iconData {
    return _iconData;
  }
}

class SettingsFieldAdd extends SettingsField {
  final _name = "Add";
  final _iconData = Icons.add;

  void onTap(BuildContext context, Budget budget) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBudgetPage(),
      ),
    );
  }
}

class SettingsFieldModify extends SettingsField {
  final _name = "Modify";
  final _iconData = Icons.edit;

  void onTap(BuildContext context, Budget budget) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBudgetPage(budget),
      ),
    );
  }
}

class SettingsFieldDelete extends SettingsField {
  final _name = "Delete";
  final _iconData = Icons.delete_forever;

  void onTap(BuildContext context, Budget budget) {
    BlocProvider.of<BudgetsBloc>(context).add(BudgetDeleted(budget));
    Navigator.pop(context);
  }
}
