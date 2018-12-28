import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>{
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            emailField(),
            passwordField(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'you@example.com'
      ),
      validator: (String value) {
        // return null if valid
        // otherwise string (with the error message) if invalid
        if (!value.contains('@')) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Password'
      ),
      validator: (String value) {
        if (value.length < 4) {
          return 'Password must be at least 4 characters';
        }
      },
      onSaved: (String value) {
        password = value;
      }
    );
  }

  Widget submitButton() {
    return RaisedButton(
      child: new Text('Login'),
      color: Colors.blue,
      onPressed: () {
        if (formKey.currentState.validate())
          formKey.currentState.save();
          print('Time to post $email & $password to my API');
      },
    );
  }
}