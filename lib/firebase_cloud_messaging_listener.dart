import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'package:hsapp/networking/id_database_helper.dart';
import 'package:random_string/random_string.dart';
import 'package:http/http.dart' as http;
import 'package:hsapp/mainPage/notifications_page.dart';
import 'package:hsapp/mainPage/front_page.dart';

class FirebaseCloudMessaging {
  static firebaseCloudMessagingListener(FirebaseMessaging _firebaseMessaging, BuildContext context) {
    if (Platform.isIOS) iOSPermission(_firebaseMessaging);
    //TODO add permission screen for android


    _firebaseMessaging.getToken().then((token){
      _uploadDeviceID(token);
      print('token: $token');
    });

     _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => FrontPage.myNotifications(context))
        // );
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => FrontPage.myNotifications(context))
        // );
      },
    );

  }

}

void iOSPermission(FirebaseMessaging _firebaseMessaging) {
  _firebaseMessaging.requestNotificationPermissions(
      IosNotificationSettings(sound: true, badge: true, alert: true) //TODO add this to settings page
  );
  _firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings)
  {
    print("Settings registered: $settings");
  });
}

_uploadDeviceID(String token) async {
  if (await _needToAddID() == true) {
    var myID = randomAlphaNumeric(100);
    await _saveID(
        id: myID,
    );
    _sendJson(myID, token);
  } else {
    IDDatabaseHelper helper = IDDatabaseHelper.instance;
    var myId = await helper.queryID();
    _sendJsonToken(myId.myId, token);
  }
}

_needToAddID() async {
  IDDatabaseHelper helper = IDDatabaseHelper.instance;
  bool myId = await helper.doesExist();
  if (myId == true) {
    return false;
  } else {
    return true;
  }
}

_saveID({id: String}) async {
  MyId myId = MyId();
  myId.myId = id;
  IDDatabaseHelper helper = IDDatabaseHelper.instance;
  print(myId);
  await helper.insert(myId);
}

Future<void> _sendJson(String myID, String token) async {
  final paramDic = {
    "ID": '$myID', 
    "token": '$token',
  };
  await http.post(
    "https://app.lttwchurch.org/setDeviceID.php",
    body: paramDic,
  );
}

Future<void> _sendJsonToken(String myID, String token) async {
  final paramDic = {
    "ID": '$myID', 
    "token": '$token',
  };
  await http.post(
    "https://app.lttwchurch.org/updateToken.php",
    body: paramDic,
  );
}