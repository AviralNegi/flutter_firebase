import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DataBase extends StatefulWidget {
  @override
  _DataBaseState createState() => _DataBaseState();
}

class _DataBaseState extends State<DataBase> {
  //connecting to fireStore
  var _firebasefirestore = FirebaseFirestore.instance;
  String command = "date";
  Response response;
  var map;

  void web() async {
    response = await get("http://192.168.187.130/cgi-bin/web.py?x=$command");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Linux Command"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 20.0),
        child: Form(
          child: Column(
            children: <Widget>[
              Center(
                child: TextField(
                  autofocus: true,
                  onChanged: (str) {
                    setState(() {
                      command = str;
                    });
                  },
                ),
              ),
              SizedBox(height: 20.0,),
              Center(
                child: RaisedButton(
                  child: Text("Add Data",style: TextStyle(color: Colors.white),),
                  color: Colors.black,
                  onPressed: () async {
                    web();
                    if (response != null) {
                      await _firebasefirestore.collection("Linux_Command").add(
                          {"Command": "$command", "Output": "${response.body}"});
                      print("$command  ${response.body}");
                    }
                  },
                ),
              ),
              SizedBox(height: 20.0,),
              Center(
                child: RaisedButton(
                  child: Text("Retrieve Data",style: TextStyle(color: Colors.white),),
                  color: Colors.black,
                  onPressed: () async {
                    var d = await _firebasefirestore
                        .collection("Linux_Command")
                        .get();
                   setState(() {
                     var size = d.size;
                     print(size);
                     map = d.docs[0].data();
                   });
                    print("${map["Command"]}  ${map["Output"]}");
                  },
                ),
              ),
              SizedBox(height: 20.0,),
              Text(map==null?"Command":"${map["Command"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.blue
              ),),
              SizedBox(height: 20.0,),
              Text(map==null?"Output":"${map["Output"]}",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue
              ),),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(DiagnosticsProperty<FirebaseFirestore>(
  //       '_firebasefirestore', _firebasefirestore));
  // }
}
