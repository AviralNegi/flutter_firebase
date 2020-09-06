import 'package:flutter/material.dart';
import 'package:flutter_firebase/Services/auth.dart';
import 'package:flutter_firebase/Shared/constants.dart';
import 'package:flutter_firebase/Shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
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
        title: Text("Register Into Brew"),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            label: Text("sign in"),
            icon: Icon(Icons.person),
            onPressed: () async {
              widget.toggleView();
            },
          )
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
                validator: (val) => val.length < 6 ? "Enter password with 6 or more characters":null,
                obscureText: true,
                onChanged: (val) {
                  password = val;
                },
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result==null){
                      setState(() {
                        error = "Enter valid email and password";
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
