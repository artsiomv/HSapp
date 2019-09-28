import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AboutAppPage extends StatelessWidget {
  AboutAppPage({Key key}) : super(key:key);

  Widget build(BuildContext context) {
    return _myListView(context);
  }
  Widget _myListView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
        appBar: AppBar(
        title: Text('About'),
      ),
      body: Container(
        padding: new EdgeInsets.only(right: 10.0, left: 10.0),
        child: new SingleChildScrollView(
          child: Text("App Name: HS app\nVersion: 1.0.2", 
            style: new TextStyle(
              fontSize: 20,
            )
          ),
        ),
      ),
    );
  }
}