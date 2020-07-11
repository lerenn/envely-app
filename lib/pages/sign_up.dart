import 'package:Envely/models/models.dart';
import 'package:flutter/material.dart';

import 'package:Envely/ui/ui.dart';

class SignIn extends StatelessWidget {
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
                  form(context, screenInformations),
                ],
              );
            } else {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        explainations(context, screenInformations),
                        form(context, screenInformations),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  ]);
            }
          })))),
    );
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
            margin: new EdgeInsets.all(20.0),
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

  Column form(BuildContext context, ScreenInformations screenInformations) {
    double size;
    if (screenInformations.orientation == Orientation.landscape &&
        screenInformations.screenSize.width < 700)
      size = screenInformations.screenSize.width;
    else
      size = 700;
    return Column(children: <Widget>[
      Container(
          width: size,
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
    ]);
  }

  SizedBox separator() {
    return SizedBox(
      height: 6,
    );
  }

  TextFormField lastNameField(BuildContext context) {
    return TextFormField(
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
    _onSignUpButtonPressed() {}

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
