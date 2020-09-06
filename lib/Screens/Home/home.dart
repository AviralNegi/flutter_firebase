import 'package:flutter/material.dart';
import 'package:flutter_firebase/Screens/Home/brew_list.dart';
import 'package:flutter_firebase/Screens/Home/settings_form.dart';
import 'package:flutter_firebase/Services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase/Services/database.dart';
import 'package:flutter_firebase/models/brew.dart';


class Home extends StatelessWidget {
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
      showModalBottomSheet(context: context,builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseServices().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        body: Container(
          decoration: BoxDecoration(
            image:  DecorationImage(
              image:  AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover
            )
          ),
            child: BrewList(),),
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text("Brew Crew"),
          actions: <Widget>[
            FlatButton.icon(
              label: Text("logout"),
              icon: Icon(Icons.person),
              onPressed: ()async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(onPressed: (){
              _showSettingsPanel();
            }, icon: Icon(Icons.settings), label: Text('settings'))
          ],
        ),
      ),
    );
  }
}
