import 'package:flutter/material.dart';

class BudgetDropdownMenu extends StatefulWidget {
  final BudgetSelectionController controller;

  BudgetDropdownMenu({@required this.controller});

  @override
  _BudgetDropdownMenuState createState() => _BudgetDropdownMenuState();
}

class _BudgetDropdownMenuState extends State<BudgetDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Theme.of(context).primaryColor,
      value: widget.controller.budgetName,
      icon: Icon(Icons.layers),
      iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
      items: ['Personal', 'Business', 'Couple'].map((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value + " "));
      }).toList(),
      style: TextStyle(
          fontSize: 20, color: Theme.of(context).colorScheme.onSecondary),
      onChanged: (String newValue) {
        setState(() {
          widget.controller.budgetName = newValue;
        });
      },
      underline: Container(height: 0),
    );
  }
}

class BudgetSelectionController {
  String budgetName = "Personal";
}
