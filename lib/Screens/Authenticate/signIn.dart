import 'package:flutter/material.dart';
import 'package:flutter_firebase/Services/auth.dart';
import 'package:flutter_firebase/Shared/constants.dart';
import 'package:flutter_firebase/Shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Text data Inside text field
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Sign Into Brew"),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Register"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (val) => val.isEmpty? "Enter Email":null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                obscureText: true,
                validator: (val) => val.length < 6 ? "Enter password with 6 or more characters":null,
                onChanged: (val) {
                  password = val;
                },
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  "SignIn",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result==null){
                      setState(() {
                        error = "could not sign in with those credentials";
                        loading = false;
                      });
                    }

                  }
                },
              ),
              SizedBox(height: 20.0,),
              Text(error,style: TextStyle(color: Colors.red),),
            ],
          ),
        ),
      ),
    );
  }
}