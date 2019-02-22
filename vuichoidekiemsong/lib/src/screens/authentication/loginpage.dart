import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/usermanagement.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  String _email;
  String _password;

  bool isSignedIn = UserManagement.isSignedIn();

  @override
  Widget build(BuildContext context) {
    print('login > isSignedIn: $isSignedIn');
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
                  child: Text('Login'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: () => {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _email, password: _password)
                            .then((FirebaseUser user) {
                          Navigator.of(context)
                              .pushReplacementNamed('/homepage');
                        }).catchError((onError) {
                          print(onError);
                        })
                      }),
              SizedBox(
                height: 15.0,
              ),
              Text('Don\'t have an account?'),
              SizedBox(height: 10.0),
              RaisedButton(
                child: Text('Sign Up'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () => Navigator.of(context).pushNamed('/signup'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
