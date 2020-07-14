import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Envely/pages/pages.dart';
import 'package:Envely/ui/ui.dart';
import 'package:Envely/blocs/blocs.dart';
import 'package:Envely/services/services.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is AuthenticationNotAuthenticated)
            return Center(child: SingleChildScrollView(child: _AuthForm()));
          if (state is AuthenticationFailure)
            return _AuthFailure(message: state.message);
          return _Loading();
        }),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenInfosWidget(builder: (context, screenInformations) {
      if (screenInformations.orientation == Orientation.portrait) {
        return Column(
          children: <Widget>[
            iconLogin(),
            signInWithLoginBloc(context),
          ],
        );
      } else {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  iconLogin(),
                  signInWithLoginBloc(context),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ]);
      }
    });
  }

  Image iconLogin() {
    return Image(
        image: AssetImage('assets/images/icons/envely-1024.png'), width: 150);
  }

  BlocProvider signInWithLoginBloc(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
          BlocProvider.of<AuthenticationBloc>(context),
          RepositoryProvider.of<AuthenticationService>(context)),
      child: _SignInForm(),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        _showError(state.error);
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is LoginLoading) {
        return Center(
          child:
              Container(margin: new EdgeInsets.all(100.0), child: _Loading()),
        );
      }

      return Form(
          key: _key,
          autovalidate: _autoValidate,
          child: ScreenInfosWidget(builder: (context, screenInformations) {
            double size;
            if (screenInformations.orientation == Orientation.landscape)
              size = screenInformations.screenSize.width / 3;
            else
              size = 500;

            return Container(
                margin: new EdgeInsets.all(25.0),
                width: size,
                child: Column(
                  children: <Widget>[
                    emailField(),
                    const SizedBox(
                      height: 12,
                    ),
                    passwordField(),
                    const SizedBox(
                      height: 12,
                    ),
                    signInButton(state),
                    signUpButton(state),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ));
          }));
    }));
  }

  TextFormField emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email address',
        labelStyle: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        filled: true,
        isDense: true,
      ),
      style: TextStyle(
        color: Theme.of(context).secondaryHeaderColor,
      ),
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      validator: (value) {
        if (value == null) {
          return 'Email is required.';
        }
        return null;
      },
    );
  }

  TextFormField passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        filled: true,
        isDense: true,
      ),
      obscureText: true,
      controller: _passwordController,
      style: TextStyle(
        color: Theme.of(context).secondaryHeaderColor,
      ),
      validator: (value) {
        if (value == null) {
          return 'Password is required.';
        }
        return null;
      },
    );
  }

  RaisedButton signInButton(LoginState state) {
    _onSignInButtonPressed() {
      if (_key.currentState.validate()) {
        BlocProvider.of<LoginBloc>(context).add(LoginInWithEmailButtonPressed(
            email: _emailController.text, password: _passwordController.text));
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return RaisedButton(
      color: Theme.of(context).secondaryHeaderColor,
      textColor: Theme.of(context).primaryColor,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)),
      child: Text('SIGN IN'),
      onPressed: state is LoginLoading ? () {} : _onSignInButtonPressed,
    );
  }

  FlatButton signUpButton(LoginState state) {
    _onSignUpButtonPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
      );
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

  void _showError(String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Theme.of(context).errorColor,
    ));
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
