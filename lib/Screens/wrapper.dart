import 'package:flutter/material.dart';
import 'package:flutter_firebase/Screens/Authenticate/authenticate.dart';
import 'package:flutter_firebase/Screens/Home/home.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FireUser>(context);
    print("User id $user");
    if(user==null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
