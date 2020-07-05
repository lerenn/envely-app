// import 'package:flutter/material.dart';

// import 'package:envely/pages/login_page.dart';

// main() => runApp(Envely());

// class Envely extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Envely',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: LoginScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:envely/blocs/blocs.dart';
import 'package:envely/services/services.dart';
import 'package:envely/pages/pages.dart';

void main() => runApp(
        // Injects the Authentication service
        RepositoryProvider<AuthenticationService>(
      create: (context) {
        return FakeAuthenticationService();
      },
      // Injects the Authentication BLoC
      child: BlocProvider<AuthenticationBloc>(
        create: (context) {
          final authService =
              RepositoryProvider.of<AuthenticationService>(context);
          return AuthenticationBloc(authService)..add(AppLoaded());
        },
        child: MyApp(),
      ),
    ));

Map<int, Color> color = {
  050: Color.fromRGBO(0x71, 0xC8, 0x37, 0.1),
  100: Color.fromRGBO(0x71, 0xC8, 0x37, 0.2),
  200: Color.fromRGBO(0x71, 0xC8, 0x37, 0.3),
  300: Color.fromRGBO(0x71, 0xC8, 0x37, 0.4),
  400: Color.fromRGBO(0x71, 0xC8, 0x37, 0.5),
  500: Color.fromRGBO(0x71, 0xC8, 0x37, 0.6),
  600: Color.fromRGBO(0x71, 0xC8, 0x37, 0.7),
  700: Color.fromRGBO(0x71, 0xC8, 0x37, 0.8),
  800: Color.fromRGBO(0x71, 0xC8, 0x37, 0.9),
  900: Color.fromRGBO(0x71, 0xC8, 0x37, 1.0),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Envely',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF71C837, color),
        // primarySwatch: Colors.green,
        secondaryHeaderColor: Colors.white,
        hintColor: Colors.green,
      ),
      // BlocBuilder will listen to changes in AuthenticationState
      // and build an appropriate widget based on the state.
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            // show home page
            return HomePage(
              user: state.user,
            );
          }
          // otherwise show login page
          return LoginPage();
        },
      ),
    );
  }
}
