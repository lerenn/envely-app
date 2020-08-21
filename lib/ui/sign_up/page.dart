import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Envely/repositories/repositories.dart';
import 'package:Envely/ui/common/common.dart';
import 'package:Envely/blocs/blocs.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is AuthenticationNotAuthenticated) return SignUpContent();
          if (state is AuthenticationAuthenticated ||
              state is AuthenticationFailure) Navigator.pop(context);
          return Loading(true);
        }),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

class SignUpContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Container(
                constraints: BoxConstraints(maxWidth: 400),
                width: ScreenUtil().setWidth(1080),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _Explainations(),
                    _SignUpWithLoginBloc(),
                    _GoBackButton(),
                  ],
                ))));
  }
}

class _GoBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.pop(context);
      },
      textColor: Theme.of(context).secondaryHeaderColor,
      child: Text(
        "Go Back",
      ),
    );
  }
}

class _Explainations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            padding: new EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Budget for People',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
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
                        fontSize: 20,
                      ),
                    ),
                  )
                ])));
  }
}

class _SignUpWithLoginBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
          BlocProvider.of<AuthenticationBloc>(context),
          RepositoryProvider.of<AuthenticationRepository>(context)),
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
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      if (state is SignUpLoading) return _SignUpLoading();
      if (state is SignUpFailure) return _SignUpError(state.error);

      return Form(
          key: _key,
          autovalidate: _autoValidate,
          child: Container(
              child: Column(children: <Widget>[
            Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(8.0)),
                margin:
                    new EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                padding: new EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  nameField(context),
                  separator(),
                  emailField(context),
                  separator(),
                  passwordField(context),
                  separator(),
                  signUpButton(context),
                ], crossAxisAlignment: CrossAxisAlignment.stretch)),
            conditions(context),
          ])));
    });
  }

  Container conditions(BuildContext context) {
    return Container(
        child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: TextStyle(color: Theme.of(context).hintColor),
          text:
              'By clicking “Sign up”, you agree to our Terms of Repository and Privacy Statement. We’ll occasionally send you account related emails.'),
    ));
  }

  SizedBox separator() {
    return SizedBox(
      height: 6,
    );
  }

  TextFormField nameField(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Name',
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
          return 'Name is required.';
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
            name: _nameController.text,
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

class _SignUpError extends StatelessWidget {
  final String message;

  _SignUpError(this.message);

  @override
  Widget build(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).errorColor,
    ));

    return null;
  }
}

class _SignUpLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(margin: new EdgeInsets.all(100.0), child: Loading(true)),
    );
  }
}
