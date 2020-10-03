import 'package:flutter/material.dart';

import 'package:housekeeping/widgets/loading_modal.dart';
import 'package:housekeeping/services/auth_service.dart';
import 'package:housekeeping/widgets/or_divider.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = "/register";

  const RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Register"),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
            children: [
              Form(
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
                      onSaved: (String value) {
                        _email = value;
                      },
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
                      onSaved: (String value) {
                        _password = value;
                      },
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      onPressed: () => submitRegister(false),
                      child: Text("Register with e-mail"),
                    ),
                    OrDivider(),
                    RaisedButton(
                      color: Colors.green[700],
                      onPressed: () => submitRegister(true),
                      child: Text(
                        "Register with Google",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_loading) Container(child: LoadingModal()),
        ],
      ),
    );
  }

  Future<void> submitRegister(bool useGoogle) async {
    // Hide keyboard
    FocusManager.instance.primaryFocus.unfocus();

    if (useGoogle) {
      setState(() {
        _loading = true;
      });
      await authService.registerWithGoogle();
    } else {
      if (_formKey.currentState.validate()) {
        setState(() {
          _loading = true;
        });

        try {
          final FormState form = _formKey.currentState;
          form.save();
          await authService.registerWithEmail(_email, _password);
        } catch (e) {
          print(e);
        }
      }
    }

    setState(() {
      _loading = false;
    });
  }
}
