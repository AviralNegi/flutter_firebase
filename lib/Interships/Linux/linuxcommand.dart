import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';

class LinuxCommand extends StatefulWidget {
  @override
  _LinuxCommandState createState() => _LinuxCommandState();
}

class _LinuxCommandState extends State<LinuxCommand> {
  @override
  String str = "date";
  Response response;

  void web(s) async {
    response = await get("https://www.w3schools.com/");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.accessibility),
        title: Title(
          child: Text("Linux Command"),
          color: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        //Creates Scrollable view
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (s) {
                setState(() {
                  str = s;
                });
              },
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  web(str);
                });
              },
              child: Text("RUN COMMAND"),
            ),
            Text(response == null ? "TEXT" : response.body)
          ],
        ),
      ),
    );
  }
}
