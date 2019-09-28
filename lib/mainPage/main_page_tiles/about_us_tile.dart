import 'package:flutter/material.dart';
import 'package:hsapp/mainPage/about_us_page.dart';

class AboutUsTile {
  static Widget aboutUsTile(TextStyle style, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AboutUs()));
      },
      child: Container(
        height: 200,
        child: Center(child: Text('ABOUT US', style: style)),
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
                color: Colors.black,
                offset: new Offset(0.0, 5.0),
                blurRadius: 40.0,
                spreadRadius: 30.0)
          ],
          image: DecorationImage(
            image: AssetImage('lib/assets/images/pic6.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}