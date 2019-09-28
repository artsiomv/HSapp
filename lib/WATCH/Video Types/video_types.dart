import 'package:flutter/material.dart';
import 'package:hsapp/WATCH/videos_list.dart';


class VideoTypes extends StatelessWidget {
  final TextStyle style;

  VideoTypes({this.style, Key key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(title: Text('WATCH'),),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            _sermonTile(style, context),
            _testimoniesTile(style, context),
          ]
        ).toList(),
      ),
    );
  }

 
}

Widget _sermonTile(TextStyle style, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => VideosList()));
    },
    child: Container(
      height: 200,
      child: Center(child: Text('SERMONS', style: style)),
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

Widget _testimoniesTile(TextStyle style, BuildContext context) {
  return GestureDetector(
    onTap: () {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Videos()));
    },
    child: Container(
      height: 200,
      child: Center(child: Text('TESTIMONIES', style: style)),
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