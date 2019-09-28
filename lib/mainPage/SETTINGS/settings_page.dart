import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hsapp/mainPage/SETTINGS/about_app.dart';
import 'package:line_icons/line_icons.dart';
import 'package:hsapp/mainPage/SETTINGS/settings_tile.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:hsapp/mainPage/SETTINGS/privacy_policy_page.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  Settings({Key key}) : super(key:key);

  Widget build(BuildContext context) {
    return _myListView(context);
  }
  Widget _myListView(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[900],
        appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              LineIcons.user,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              openBrowser('https://www.app.lttwchurch.org/LTTW_app_php/');
            },
          ),
        ],
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            SettingsTile(icon: Icon(Icons.chat), title:  Text("Send Feedback"),
              action: () {
                sendFeedback(context);
              }
            ),
            SettingsTile(icon: Icon(Icons.lock_outline), title:  Text("Privacy Policy"),
              action: () { //https://docs.google.com/document/d/1KWFhs4axHWZbVigu9DqH4FvyjhhvZHiZUCRnHnRr3yo/edit?usp=sharing
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));
              }
            ),
            SettingsTile(icon: Icon(Icons.group), title:  Text("About"),
              action: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutAppPage()));
              }
            ),
          ]
        ).toList(),
      ),
    );
  }
}

sendFeedback(BuildContext context) async {
  final Email email = Email( //TODO add correct email settings
    body: 'Email body',
    subject: 'Email subject',
    recipients: ['example@example.com'],
  );

  try {
    await FlutterEmailSender.send(email);
  } on PlatformException catch(e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Sorry, no email is setup."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],

        );
      }
    );
  }
}

openBrowser(String url) async{
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}