import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Envely/models/models.dart';
import 'package:Envely/ui/ui.dart';
import 'package:Envely/services/services.dart';
import 'package:Envely/blocs/blocs.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is AuthenticationNotAuthenticated) return SignUpContent();
          if (state is AuthenticationFailure)
            return _AuthFailure(message: state.message);
          if (state is AuthenticationAuthenticated) Navigator.pop(context);
          return _Loading();
        }),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

class SignUpContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Center(child: SingleChildScrollView(
              child: ScreenInfosWidget(builder: (context, screenInformations) {
            if (screenInformations.orientation == Orientation.portrait ||
                screenInformations.screenSize.width < 700) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  explainations(context, screenInformations),
                  signUpWithLoginBloc(context),
                ],
              );
            } else {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        explainations(context, screenInformations),
                        signUpWithLoginBloc(context),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  ]);
            }
          })))),
    );
  }

  Container explainations(
      BuildContext context, ScreenInformations screenInformations) {
    var size;

    if (screenInformations.orientation == Orientation.portrait)
      size = screenInformations.screenSize.height;
    else
      size = screenInformations.screenSize.width;

    return Container(
        width: size * 1 / 2,
        child: Container(
            padding: new EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Budget for People',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size / 20,
                          color: Theme.of(context).hintColor),
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'Start your journey today and make your dreams a priority.',
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontStyle: FontStyle.italic,
                        fontSize: size / 30,
                      ),
                    ),
                  )
                ])));
  }

  BlocProvider signUpWithLoginBloc(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
          BlocProvider.of<AuthenticationBloc>(context),
          RepositoryProvider.of<AuthenticationService>(context)),
      child: _SignUpForm(),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        autovalidate: _autoValidate,
        child: ScreenInfosWidget(builder: (context, screenInformations) {
          double size;
          if (screenInformations.orientation == Orientation.landscape &&
              screenInformations.screenSize.width >= 700)
            size = screenInformations.screenSize.width * 1 / 3;
          else
            size = screenInformations.screenSize.width;
          return Container(
              width: size,
              child: Column(children: <Widget>[
                Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(8.0)),
                    // shape: new RoundedRectangleBorder(
                    //   borderRadius: new BorderRadius.circular(8.0)),
                    margin: new EdgeInsets.all(20.0),
                    padding: new EdgeInsets.all(10.0),
                    child: Column(children: <Widget>[
                      lastNameField(context),
                      separator(),
                      firstNameField(context),
                      separator(),
                      emailField(context),
                      separator(),
                      passwordField(context),
                      separator(),
                      signUpButton(context),
                    ], crossAxisAlignment: CrossAxisAlignment.stretch)),
                conditions(context, size),
              ]));
        }));
  }

  Container conditions(BuildContext context, double size) {
    return Container(
        width: size,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: TextStyle(color: Theme.of(context).hintColor),
              text:
                  'By clicking “Sign up”, you agree to our Terms of Service and Privacy Statement. We’ll occasionally send you account related emails.'),
        ));
  }

  SizedBox separator() {
    return SizedBox(
      height: 6,
    );
  }

  TextFormField lastNameField(BuildContext context) {
    return TextFormField(
      controller: _lastNameController,
      decoration: InputDecoration(
        labelText: 'Last Name',
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        filled: true,
        isDense: true,
      ),
      style: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null) {
          return 'Last name is required.';
        }
        return null;
      },
    );
  }

  TextFormField firstNameField(BuildContext context) {
    return TextFormField(
      controller: _firstNameController,
      decoration: InputDecoration(
        labelText: 'First Name',
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        filled: true,
        isDense: true,
      ),
      style: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null) {
          return 'First name is required.';
        }
        return null;
      },
    );
  }

  TextFormField emailField(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email address',
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        filled: true,
        isDense: true,
      ),
      style: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null) {
          return 'Email is required.';
        }
        return null;
      },
    );
  }

  TextFormField passwordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        filled: true,
        isDense: true,
      ),
      obscureText: true,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      validator: (value) {
        if (value == null) {
          return 'Password is required.';
        }
        return null;
      },
    );
  }

  FlatButton signUpButton(BuildContext context) {
    _onSignUpButtonPressed() {
      if (_key.currentState.validate()) {
        BlocProvider.of<SignUpBloc>(context).add(SignUpInWithEmailButtonPressed(
            lastName: _lastNameController.text,
            firstName: _firstNameController.text,
            email: _emailController.text,
            password: _passwordController.text));
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return FlatButton(
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).secondaryHeaderColor,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)),
      child: Text('SIGN UP'),
      onPressed: _onSignUpButtonPressed,
    );
  }
}

class _AuthFailure extends StatelessWidget {
  final String message;

  _AuthFailure({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        RichText(
            text: TextSpan(
                text: message,
                style: TextStyle(color: Theme.of(context).hintColor))),
        FlatButton(
            color: Colors.white,
            textColor: Theme.of(context).primaryColor,
            child: Text('Retry'),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(AppLoaded());
            })
      ],
    ));
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      strokeWidth: 2,
    ));
  }
}
