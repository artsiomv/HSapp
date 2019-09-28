import 'package:flutter/material.dart';
import 'package:hsapp/networking/event_network.dart';
import 'package:hsapp/tiles/image_tile.dart';
import 'package:hsapp/tiles/text_tile.dart';
import 'package:hsapp/tiles/text_button_tile.dart';
import 'package:hsapp/tiles/two_actions_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:line_icons/line_icons.dart';
import 'package:hsapp/parseDate.dart';
class EventDetailsScreen extends StatelessWidget {
  final MyEvent event;
  EventDetailsScreen({Key key, @required this.event}) : super(key:key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(title: Text(event.title),),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ImageTile(imageName: event.imageName, type: 'uploadsEvent',),
            Divider(color: Colors.grey[800], height: 1,),
            TwoActionTile(
              name1: 'Save Event',
              name2: 'Directions',
              iconOne: LineIcons.calendar_check_o,
              iconTwo: LineIcons.map,
              action: () { //TODO add a functionality to add events to the calendar
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PlayVideo(video.videoURL)
                //   )
                // );
              },
              action2: () {
                openMaps();
              },
            
            ),
            Divider(color: Colors.grey[800], height: 1),
            TextTile(body: event.description, name: 'Description'),
            Divider(color: Colors.grey[800], height: 1),
            TextButtonTile(
              body: ParseDate.parseDate(event.startDate, event.endDate, event.startTime), //TODO parse time to american format
              name: 'Save Event',
              icon: LineIcons.calendar_check_o, 
              action: () {
                //TODO add a functionality to add events to the calendar
              }
            ),
            Divider(color: Colors.grey[800], height: 1),
            TextButtonTile(body: event.address, name: 'Directions', icon: LineIcons.map,
              action: () {
                openMaps();
              }
            ),
            Divider(color: Colors.grey[800], height: 1),
          ]
        ).toList(),
      ),
    );
  }

  openMaps() async {
    //TODO: check if it works for regular address
    String myUrl = 'https://www.google.com/maps/place/${event.address}'; 
    String googleUrl = myUrl.replaceAll(new RegExp(" "), "+");
    
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      // throw 'Could not open the map.';//TODO geve a popup to the user that the map could not be opened
    }
  }

  saveEvent() async {
    
  }

  // String parseDateToLookGood(String startDate, endDate) {
  //   var dateArrayStart = startDate.split("-");
  //   var dateArrayEnd = endDate.split("-");
  //   if(dateArrayStart[1] == dateArrayEnd[1] && dateArrayStart[0] == dateArrayEnd[0]) {
      // return getMonthName(dateArrayStart[1]) + " " + dateArrayStart[2];
  //   }

  //   return getMonthName(dateArrayStart[1]) + " " + dateArrayStart[2] + "," + dateArrayStart[0] + " - " + getMonthName(dateArrayEnd[1]) + " " + dateArrayEnd[2] + "," + dateArrayEnd[0];
  // }

  // String getMonthName(String month) {
  //   List<String> monthArray = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  //   return monthArray[int.parse(month) -1];
  // }

  // String parseTimeToLookGood(String time) {
  //   var dateArray = time.split(":");
  //   String timeOfDay = "";
  //   if(int.parse(dateArray[0]) >= 12 ) {
  //     timeOfDay = "PM";
  //   } else {
  //     timeOfDay = "AM";
  //   }
  //   int myHour = int.parse(dateArray[0]);
  //   if(myHour > 12) {
  //     return (myHour - 12).toString() + ":" + dateArray[1] + " " + timeOfDay;
  //   } else {
  //     return myHour.toString() + ":" + dateArray[1] + " " + timeOfDay;
  //   }
  // }

}