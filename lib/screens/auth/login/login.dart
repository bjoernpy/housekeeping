import 'package:flutter/material.dart';

import 'package:housekeeping/widgets/loading_modal.dart';
import 'package:housekeeping/routes.dart';
import 'package:housekeeping/services/auth_service.dart';
import 'package:housekeeping/widgets/or_divider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    "HOUSEKEEPING\nAPP",
                    style: TextStyle(letterSpacing: 1.5, fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  buildLoginForm(),
                  OrDivider(),
                  RaisedButton(
                    color: Colors.green[700],
                    onPressed: submitLoginWithGoogle,
                    child: Text("Login with Google"),
                  ),
                  Spacer(),
                  Text("You don't have an account yet?"),
                  FlatButton(
                    onPressed: () => Navigator.pushNamed(context, RouteNames.register),
                    child: Text("Register"),
                  ),
                ],
              ),
            ),
            if (_loading) Container(child: LoadingModal()),
          ],
        ),
      ),
    );
  }

  Form buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              hintText: "Enter your e-mail address",
              labelText: "E-mail",
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter your e-mail address";
              }
              if (!value.contains("@")) {
                return "Please enter a valid e-mail address";
              }
              return null;
            },
            onSaved: (String value) => _email = value,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.vpn_key),
              hintText: "Enter your password",
              labelText: "Password",
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter password";
              }
              return null;
            },
            onSaved: (String value) => _password = value,
          ),
          SizedBox(height: 20),
          RaisedButton(
            onPressed: submitLoginWithEmail,
            child: Text("Login with e-mail"),
          ),
        ],
      ),
    );
  }

  Future<void> submitLoginWithEmail() async {
    if (_formKey.currentState.validate()) {
      FocusManager.instance.primaryFocus.unfocus();
      setState(() {
        _loading = true;
      });
      try {
        final FormState form = _formKey.currentState;
        form.save();
        await authService.signInWithEmail(_email, _password);
      } catch (e) {
        print(e);
      }
      if (mounted)
        setState(() {
          _loading = false;
        });
    }
  }

  Future<void> submitLoginWithGoogle() async {
    setState(() {
      _loading = true;
    });
    try {
      await authService.singInWithGoogle();
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
