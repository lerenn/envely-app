import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AccountNameField extends StatelessWidget {
  final TextEditingController controller;

  AccountNameField({@required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Account name',
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        filled: true,
        isDense: true,
      ),
      style: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      controller: controller,
      keyboardType: TextInputType.name,
      autocorrect: false,
      validator: (value) {
        if (value == null || value == "") {
          return 'Name is required.';
        }
        return null;
      },
    );
  }
}
