import 'package:flutter/material.dart';
import 'package:hsapp/WATCH/videos_list.dart';
import 'package:hsapp/WATCH/Video Types/video_types.dart';

class WatchTile {
  static Widget watchTile(TextStyle style, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => VideoTypes(style: style)));
      },
      child: Container(
        height: 200,
        child: Center(child: Text('WATCH', style: style)),
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
                color: Colors.black,
                offset: new Offset(0.0, 5.0),
                blurRadius: 40.0,
                spreadRadius: 40.0)
          ],
          image: DecorationImage(
            image: AssetImage('lib/assets/images/pic1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}