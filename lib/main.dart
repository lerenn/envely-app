import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Envely/blocs/blocs.dart';
import 'package:Envely/repositories/repositories.dart';
import 'package:Envely/ui/pages.dart';

void main() => runApp(Envely());

class Envely extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return repositoriesProvider(blocProvider(app(context)));
  }

  Widget repositoriesProvider(Widget child) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider<AccountsRepository>(
        create: (context) => FirebaseAccountsRepository(),
      ),
      RepositoryProvider<AuthenticationRepository>(
        create: (context) => FirebaseAuthenticationRepository(),
      ),
      RepositoryProvider<BudgetsRepository>(
        create: (context) => FirebaseBudgetsRepository(),
      ),
      RepositoryProvider<CategoriesRepository>(
        create: (context) => FirebaseCategoriesRepository(),
      ),
      RepositoryProvider<EnvelopsRepository>(
        create: (context) => FirebaseEnvelopsRepository(),
      ),
    ], child: child);
  }

  Widget blocProvider(Widget child) {
    CategoriesBloc catBloc;

    // Authentication
    BlocProvider<AuthenticationBloc> authBloc =
        BlocProvider<AuthenticationBloc>(create: (context) {
      return AuthenticationBloc(
          repository: RepositoryProvider.of<AuthenticationRepository>(context))
        ..add(AppLoaded());
    });

    // Budgets
    BlocProvider<BudgetsBloc> budgetsBloc = BlocProvider<BudgetsBloc>(
      create: (context) => BudgetsBloc(
          repository: RepositoryProvider.of<BudgetsRepository>(context)),
    );

    // Accounts
    BlocProvider<AccountsBloc> accountsBloc = BlocProvider<AccountsBloc>(
        create: (context) => AccountsBloc(
            repository: RepositoryProvider.of<AccountsRepository>(context)));

    // Categories
    BlocProvider<CategoriesBloc> categoriesBloc =
        BlocProvider<CategoriesBloc>(create: (context) {
      catBloc = CategoriesBloc(
          repository: RepositoryProvider.of<CategoriesRepository>(context));
      return catBloc;
    });

    // Envelops
    BlocProvider<EnvelopsBloc> envelopsBloc = BlocProvider<EnvelopsBloc>(
      create: (context) => EnvelopsBloc(
          categoriesBloc: catBloc,
          repository: RepositoryProvider.of<EnvelopsRepository>(context)),
    );

    return MultiBlocProvider(providers: [
      authBloc,
      budgetsBloc,
      accountsBloc,
      categoriesBloc,
      envelopsBloc,
    ], child: child);
  }

  Widget app(BuildContext context) {
    return MaterialApp(
      title: 'Envely',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: landingPage(context),
    );
  }

  Widget landingPage(BuildContext context) {
    // BlocBuilder will listen to changes in AuthenticationState
    // and build an appropriate widget based on the state.
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          BlocProvider.of<BudgetsBloc>(context).add(BudgetsLoad());
          return HomePage(user: state.user);
        }
        return LoginPage();
      },
    );
  }
}
