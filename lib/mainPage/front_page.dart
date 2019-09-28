import 'package:flutter/material.dart';
import 'package:hsapp/mainPage/main_page_tiles/watch_tile.dart';
import 'package:hsapp/mainPage/main_page_tiles/event_tile.dart';
import 'package:hsapp/mainPage/main_page_tiles/get_involved_tile.dart';
import 'package:hsapp/mainPage/main_page_tiles/give_tile.dart';
import 'package:hsapp/mainPage/main_page_tiles/about_us_tile.dart';
import 'package:hsapp/mainPage/main_page_tiles/carousel_page.dart';

class FrontPage {
  static Widget myListView(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          CarouselTile.carouselTile(_setStyle(), context),
          WatchTile.watchTile(_setStyle(), context),
          EventTile.eventTile(_setStyle(), context),
          GetInvolvedTile.getInvolvedTile(_setStyle(), context),
          GiveTile.giveTile(_setStyle()),
          AboutUsTile.aboutUsTile(_setStyle(), context),
        ],
      ).toList(),
    );
  }
}

TextStyle _setStyle() {
    return TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(2.0, 2.0),
          blurRadius: 3.0,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ],
    );
  }