import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GiveTile {
  static Widget giveTile(TextStyle style) {
    return GestureDetector(
      onTap: () {
        openBrowser('https://pushpay.com/fsp/lighttotheworldchurch?t=8ac91fb4-aca3-0766-9aeb-02027b672f3e');
      },
      child: Container(
        height: 200,
        child: Center(child: Text('GIVE', style: style)),
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
                color: Colors.black,
                offset: new Offset(0.0, 5.0),
                blurRadius: 40.0,
                spreadRadius: 40.0)
          ],
          image: DecorationImage(
            image: AssetImage('lib/assets/images/pic4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
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