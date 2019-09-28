import 'package:flutter/material.dart';
import 'package:hsapp/mainPage/get_involved_page.dart';

class GetInvolvedTile {
  static Widget getInvolvedTile(TextStyle style, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GetInvolved()));
      },
      child: Container(
        height: 200,
        child: Center(child: Text('GET INVOLVED', style: style)),
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
                color: Colors.black,
                offset: new Offset(0.0, 5.0),
                blurRadius: 40.0,
                spreadRadius: 40.0)
          ],
          image: DecorationImage(
            image: AssetImage('lib/assets/images/pic3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}