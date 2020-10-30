import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:Envely/logic/models/models.dart';

class BudgetCurrencyField extends StatefulWidget {
  final BudgetCurrencyFieldController controller;

  BudgetCurrencyField({@required this.controller});

  @override
  _BudgetCurrencyFieldState createState() => _BudgetCurrencyFieldState();
}

class _BudgetCurrencyFieldState extends State<BudgetCurrencyField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: DropdownButton<Currency>(
          value: widget.controller.currency,
          isExpanded: true,
          items: Currency.values
              .where((value) => value != Currency.Custom)
              .map((Currency value) {
            return DropdownMenuItem<Currency>(
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
                      text: value.short() + " (" + value.symbol() + ")",
                      style: TextStyle(color: Colors.grey),
                    )),
                  ]),
            );
          }).toList(),
          onChanged: (Currency newValue) {
            setState(() {
              widget.controller.currency = newValue;
            });
          },
          underline: Container(
            height: 0,
          ),
        ));
  }
}

class BudgetCurrencyFieldController {
  Currency currency = Currency.EUR;
}
