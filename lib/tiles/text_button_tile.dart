import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class TextButtonTile extends StatelessWidget {

  final String body;
  final String name;
  final IconData icon;
  final Function action;

  TextButtonTile({this.body, this.name, this.icon, this.action, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: action,
      child: Container(
        height: 70,
        child: Center(
          child: ListTile (
            contentPadding: EdgeInsets.only(left: 15.0, right: 15.0),
            leading: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: '$name\n', style: TextStyle(color: Colors.grey[700], fontSize: 14), ),
                  TextSpan(text: '\n$body', style: TextStyle(fontSize: 16), ),
                ],
              ),
            ),
            trailing: Icon(icon, size: 30,),
          ),
        ),
      ),
    );
  }
}
