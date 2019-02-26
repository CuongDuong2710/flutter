import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/usermanagement.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration:
                    InputDecoration(hintText: 'Email', labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 15.0),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password', labelText: 'Password'),
                onChanged: (value) => setState(() {
                      _password = value;
                    }),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  child: Text('Sign Up'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: () {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _email, password: _password)
                            .then((signedUser) {
                          print('signUppppp' + signedUser.toString());
                          UserManagement().storeNewUser(signedUser, context);
                        }).catchError((onError) {
                          print(onError);
                        });
                      })
            ],
          ),
        ),
      ),
    );
  }
}
