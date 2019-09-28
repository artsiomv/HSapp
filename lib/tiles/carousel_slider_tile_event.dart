import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hsapp/networking/event_network.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarouselSliderTileEvent extends StatelessWidget {
  final TextStyle style;
  final MyEvent event;
  final Function action;

  CarouselSliderTileEvent({this.style, this.event, this.action, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return GestureDetector(
      onTap: action,
      child: Container(
        child: Center(child: Text(event.title, style: style)),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider('https://app.lttwchurch.org/LTTW_app_php/uploadsEvent/${event.imageName}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
