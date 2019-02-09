import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'MainPage.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;
  final GlobalKey<FormState> _key = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        autovalidate: true,
        key: _key,
        child: Container(
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (value) {
                  _email = value;
                  print(_email);
                },
                decoration: InputDecoration(
                  labelText: "Username",
                ),
                validator: (value) {
                  if (value.isEmpty)
                    return "Username is required";
                  else
                    return null;
                },
              ),
              TextFormField(
                onSaved: (value) {
                  _password = value;
                },
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              RaisedButton(
                child: Text("Log in"),
                onPressed: () => _logIn(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _logIn(BuildContext context) async {
    var _fbAuth = FirebaseAuth.instance;
    _key.currentState.save();
    print("Logging in async ");
    print( _password);
    print(_email);
    FirebaseUser user;
    try {
    user = await _fbAuth.signInWithEmailAndPassword(email:_email, password:_password);
    print("user is "+ user.email);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
    } catch(e) {
      print("You can't log in. "+e.message);
    }
  }
}

