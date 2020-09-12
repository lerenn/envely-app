import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BudgetNameField extends StatelessWidget {
  final TextEditingController controller;

  BudgetNameField({@required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Budget name',
        filled: true,
        isDense: true,
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
