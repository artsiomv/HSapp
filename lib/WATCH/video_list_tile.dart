import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hsapp/networking/video_network.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoListTile extends StatelessWidget {

  final Video video;
  final Function action;

  VideoListTile({this.video, this.action, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return GestureDetector(
      onTap: action,
      child: Container(
        height: 70,
        padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          border: Border.all(color: Colors.black),
          color: Colors.black
        ),
        child: Center(
          child: ListTile (
            contentPadding: EdgeInsets.only(left: 5.0),
            leading: Container(
              padding: EdgeInsets.all(0.0),
              width:90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  image: CachedNetworkImageProvider('https://app.lttwchurch.org/LTTW_app_php/uploadsVideo/${video.imageName}'),
                  fit: BoxFit.cover,
                ),
              )
            ),
            title: Text(video.title),
            trailing: Icon(Icons.chevron_right, color: Colors.white70,),
          ),
        ),
      ),
    );
  }
}
