import 'package:flutter/material.dart';
import 'package:flutter_firebase/Services/database.dart';
import 'package:flutter_firebase/Shared/constants.dart';
import 'package:flutter_firebase/Shared/loading.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0' ,'1', '2','3','4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FireUser>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseServices(uid: user.uid ).userData,
      builder: (context, snapshot) {
         if(snapshot.hasData){
           UserData userData = snapshot.data;

           return Form(
               key: _formKey,
               child: Column(
                 children: <Widget>[
                   Text("Update your brew setting.",
                     style: TextStyle(fontSize: 18.0),),
                   SizedBox(height: 20.0,),
                   TextFormField(
                     initialValue: userData.name,
                     decoration: textInputDecoration,
                     validator: (val){
                       return val.isEmpty ? 'please enter a name' :null;
                     },
                     onChanged: (val){
                       setState(() {
                         _currentName = val;
                       });
                     },
                   ),
                   SizedBox(height: 20.0,),
                   //dropdown
                   DropdownButtonFormField(
                     decoration: textInputDecoration,
                     value:  _currentSugars ?? userData.sugars,
                     items: sugars.map((sugar){
                       return DropdownMenuItem(
                         value: sugar,
                         child: Text("$sugar sugars"),
                       );
                     }).toList(), onChanged: (String value) { _currentSugars = value; },
                   ),
                   //slider
                   Slider(
                     value: (_currentStrength ?? userData.strength).toDouble(),
                     activeColor: Colors.brown[_currentStrength ?? 100],
                     inactiveColor: Colors.brown[_currentStrength ?? 100],
                     min:100.0,max: 900.0,
                     divisions: 8,
                     onChanged: (val){
                       setState(() {
                         _currentStrength= val.round();
                       });
                     },
                   ),
                   RaisedButton(
                     color: Colors.pink[400],
                     child: Text(
                       'Update',
                       style: TextStyle(color: Colors.white),
                     ),
                     onPressed: ()async{
                       if(_formKey.currentState.validate()){
                         await DatabaseServices(uid: user.uid).updateUserData(
                             _currentSugars ?? userData.sugars,
                             _currentName ?? userData.name,
                             _currentStrength ?? userData.strength);
                         Navigator.pop(context);
                       }
                     },
                   )
                 ],
               ),
           );
         }
         else{
           return Loading();
         }

      }
    );
  }
}
