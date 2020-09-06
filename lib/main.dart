import 'package:flutter/material.dart';
import 'package:flutter_firebase/Interships/database/database.dart';
// import 'package:flutter_firebase/Interships/Linux/linuxcommand.dart';
// import 'package:flutter_firebase/Interships/database/database.dart';
import 'package:flutter_firebase/Screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/Services/auth.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyAppMe());
}

class MyAppMe extends StatefulWidget {
  @override
  _MyAppMeState createState() => _MyAppMeState();
}

class _MyAppMeState extends State<MyAppMe> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FireUser>.value(
      value: AuthServices().user,
      child: MaterialApp(
        //home: DataBase(),
        home: Wrapper(),
      ),
    );
  }
}
