import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Envely/models/models.dart';
import 'package:Envely/blocs/blocs.dart';

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
    BlocProvider.of<CategoriesBloc>(context).add(CategoriesLoad(budget));
  }
}

class BudgetControllerSingleton extends BudgetController {
  static final BudgetControllerSingleton _singleton =
      BudgetControllerSingleton._internal();

  factory BudgetControllerSingleton() {
    return _singleton;
  }

  BudgetControllerSingleton._internal();
}
