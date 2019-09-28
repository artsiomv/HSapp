import 'package:flutter/material.dart';
// import 'package:hsapp/mainPage/frontPage.dart';
import "package:hsapp/mainPage/front_page.dart";
import 'package:hsapp/mainPage/SETTINGS/settings_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hsapp/firebase_cloud_messaging_listener.dart';
import 'package:hsapp/mainPage/notifications_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HS app',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black
      ),
      home: MyHomePage(title: 'HS app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  @override
  void initState() {
    super.initState();
    FirebaseCloudMessaging.firebaseCloudMessagingListener(_firebaseMessaging, context);
    
    
  }

  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }

  Widget _myListView(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title, style: TextStyle(fontSize: 35.0)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NotificationsPage())
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings())
              );
            },
          ),
        ],
      ),
      body: FrontPage.myListView(context),
    );
  }
}
