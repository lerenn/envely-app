import 'package:flutter/widgets.dart';

import 'package:Envely/screens/screens.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  AccountAddPage.routeName: (BuildContext context) => AccountAddPage(),
  AccountEditPage.routeName: (BuildContext context) => AccountEditPage(),
  BudgetAddPage.routeName: (BuildContext context) => BudgetAddPage(),
  BudgetEditPage.routeName: (BuildContext context) => BudgetEditPage(),
  HomePage.routeName: (BuildContext context) => HomePage(),
  LoginPage.routeName: (BuildContext context) => LoginPage(),
  SignUpPage.routeName: (BuildContext context) => SignUpPage(),
};
