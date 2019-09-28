import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hsapp/networking/video_network.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarouselSliderTileVideo extends StatelessWidget {
  final TextStyle style;
  final Video video;
  final Function action;

  CarouselSliderTileVideo({this.style, this.video, this.action, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return GestureDetector(
      onTap: action,
      child: Container(
        child: Center(child: Text(video.title, style: style)),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider('https://app.lttwchurch.org/LTTW_app_php/uploadsVideo/${video.imageName}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
