import 'package:flutter/material.dart';

import 'package:housekeeping/widgets/loading_modal.dart';
import 'package:housekeeping/routes.dart';
import 'package:housekeeping/services/auth_service.dart';
import 'package:housekeeping/services/household_service.dart';

class CreateUserScreen extends StatefulWidget {
  static const String routeName = "/create_user";

  const CreateUserScreen({Key key}) : super(key: key);

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _newHousehold = true;

  String _firstName;
  String _lastName;
  String _householdName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create User"),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
            children: [buildCreateUserForm()],
          ),
          if (_loading) Container(child: LoadingModal()),
        ],
      ),
    );
  }

  Form buildCreateUserForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: "Enter your first name",
              labelText: "First name",
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter your first name";
              }
              return null;
            },
            onSaved: (String value) => _firstName = value,
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person_outline),
              hintText: "Enter your last name",
              labelText: "Last name",
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter your last name";
              }
              return null;
            },
            onSaved: (String value) => _lastName = value,
          ),
          SizedBox(height: 20),
          SwitchListTile(
            value: _newHousehold,
            onChanged: (bool value) {
              setState(() {
                _newHousehold = value;
              });
            },
            title: Text("New household"),
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.home),
              hintText: _newHousehold ? "Enter a new household name" : "Enter the household code",
              labelText: _newHousehold ? "Household name" : "Household code",
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (String value) {
              if (value.isEmpty) {
                return _newHousehold ? "Please enter a name for your household" : "Please enter the household code";
              }
              return null;
            },
            onSaved: (String value) => _householdName = value,
          ),
          SizedBox(height: 20),
          RaisedButton(
            onPressed: submitCreate,
            child: Text("Create user"),
          ),
        ],
      ),
    );
  }

  Future<void> submitCreate() async {
    if (_formKey.currentState.validate()) {
      // Hide keyboard
      FocusManager.instance.primaryFocus.unfocus();
      setState(() {
        _loading = true;
      });

      try {
        final FormState form = _formKey.currentState;
        form.save();
        await authService.createUser(_firstName, _lastName);
        if (_newHousehold) await householdService.createHousehold(_householdName);
        Navigator.pushReplacementNamed(context, RouteNames.home);
      } catch (e) {
        print(e);
      }

      setState(() {
        _loading = false;
      });
    }
  }
}
