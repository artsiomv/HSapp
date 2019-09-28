import 'package:flutter/material.dart';
import 'package:hsapp/EVENTS/event_detail_screen.dart';
import 'package:hsapp/EVENTS/events_list.dart';
import 'package:hsapp/WATCH/video_details_screen.dart';
import 'package:hsapp/networking/video_network.dart';
import 'package:hsapp/networking/event_network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hsapp/mainPage/main_page_tiles/carousel.dart';
import 'package:hsapp/tiles/carousel_slider_tile_video.dart';
import 'package:hsapp/tiles/carousel_slider_tile_event.dart';
import 'dart:io';

class CarouselTile {
  static Widget carouselTile(TextStyle style, BuildContext context) {

    var futureBuilder = new FutureBuilder(
      future: getCarouselSlides(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: new CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError)
              return new Text("fetch error");
            return createListView(context, snapshot, style);
        }
      },

    );

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => EventsList()));
      },
      child: Container(
        height: 250,
        child: futureBuilder,
      ),
    );
  }

  static createListView(BuildContext context, AsyncSnapshot snapshot, TextStyle style) {
    // List<String> values = snapshot.data;
    return new Container(
      height: 250.0,
      child: new Carousel(
        children: myWidget(snapshot, snapshot.data.length, style, context),
        // boxFit: BoxFit.cover,
        // images: snapshot.data,
        // autoplay: false,
        // dotSize: 4.0,
        // indicatorBgPadding: 4.0,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        displayDuration: Duration(seconds: 2),
      ),
    );
  }
}

List<Widget> myWidget(AsyncSnapshot snapshot, int length, TextStyle style, BuildContext context) {
  List<Widget> widgetList = new List(length);

  for(int i = 0; i < length; i++) {
    // print(snapshot.data[i].toString());
    if(snapshot.data[i].toString() == "Instance of 'Video'") {
      widgetList[i] = new Card(
        margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0),
        child: CarouselSliderTileVideo(
          style: style,
          video: snapshot.data[i],
          action: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoDetailsScreen(video:snapshot.data[i])
              )
            );
          },
        ),
      );
    } else if(snapshot.data[i].toString() == "Instance of 'MyEvent'") {
      widgetList[i] = new Card(
        margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0),
        child: CarouselSliderTileEvent(
          style: style,
          event: snapshot.data[i],
          action: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailsScreen(event:snapshot.data[i])
              )
            );
          },
        ),
      );
    }
  }
  
  return widgetList;
}

Future<List<Object>> getCarouselSlides() async {

    List<Video> videoList = new List();
    List<MyEvent> eventList = new List();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //call to a remote file
        final response = await http.get('https://app.lttwchurch.org/carouselSliderTiles.php');
        //decode to json
        final usersResponse = json.decode(response.body);

        int i = 0;
        //loop throught an array of data
        for (var item in usersResponse) { //TODO here will be Videos, Events, Testimonies ...
          if(item.toString().contains("dateSpoken") && item.toString().contains("speaker")) {
            final video = Video.fromJsonLocal(item);
            videoList.add(video);
          } else if (item.toString().contains("startDate") && item.toString().contains("endDate")) {
            final event = MyEvent.fromJsonLocal(item);
            eventList.add(event);
          }
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
    var mergedList = [...videoList, ...eventList];

    return mergedList;
  }