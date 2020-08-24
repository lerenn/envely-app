import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:Envely/models/models.dart';

class AccountTypeField extends StatefulWidget {
  final AccountTypeFieldController controller;

  AccountTypeField({@required this.controller});

  @override
  _AccountTypeFieldState createState() => _AccountTypeFieldState();
}

class _AccountTypeFieldState extends State<AccountTypeField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: DropdownButton<AccountType>(
          value: widget.controller.type,
          isExpanded: true,
          items: AccountType.values
              .where((value) => value != AccountType.Unknown)
              .map((AccountType value) {
            return DropdownMenuItem<AccountType>(
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
                      text: value.mode(),
                      style: TextStyle(color: Colors.grey),
                    )),
                  ]),
            );
          }).toList(),
          onChanged: (AccountType newValue) {
            setState(() {
              widget.controller.type = newValue;
            });
          },
          underline: Container(
            height: 0,
          ),
        ));
  }
}

class AccountTypeFieldController {
  AccountType type = AccountType.CreditCard;
}
