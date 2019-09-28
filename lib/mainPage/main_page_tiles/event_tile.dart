import 'package:flutter/material.dart';
import 'package:hsapp/EVENTS/events_list.dart';

class EventTile {
  static Widget eventTile(TextStyle style, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EventsList()));
      },
      child: Container(
        height: 200,
        child: Center(child: Text('EVENTS', style: style)),
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
                color: Colors.black,
                offset: new Offset(0.0, 5.0),
                blurRadius: 40.0,
                spreadRadius: 40.0)
          ],
          image: DecorationImage(
            image: AssetImage('lib/assets/images/pic2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}