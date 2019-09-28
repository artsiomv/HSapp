import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SettingsTile extends StatelessWidget {

  final Icon icon;
  final Text title;
  final Function action;

  SettingsTile({this.icon, this.title, this.action, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return GestureDetector(
      onTap: action,
      child: Container(
        child: Center(
          child: ListTile (
            leading: icon,
            title: title,
            trailing: Icon(Icons.chevron_right, color: Colors.white70,),
          ),
        ),
      ),
    );
  }
}
