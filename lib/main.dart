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
    ], child: child);
  }

  Widget blocProvider(Widget child) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthenticationBloc>(create: (context) {
        final authRepository =
            RepositoryProvider.of<AuthenticationRepository>(context);
        return AuthenticationBloc(authRepository)..add(AppLoaded());
      }),
      BlocProvider<AccountsBloc>(
          create: (context) => AccountsBloc(
              accountsRepository:
                  RepositoryProvider.of<AccountsRepository>(context))),
      BlocProvider<BudgetsBloc>(
        create: (context) => BudgetsBloc(
            budgetsRepository:
                RepositoryProvider.of<BudgetsRepository>(context)),
      )
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
