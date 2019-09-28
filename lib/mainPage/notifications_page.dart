import 'package:flutter/material.dart';
import 'package:hsapp/networking/notifications_network.dart';
import 'package:hsapp/tiles/notification_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({Key key}) : super(key:key);

  Widget build(BuildContext context) {
    return _myListView(context);
  }
  Widget _myListView(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Text('Notifications'),
        ),
      ),
      body: Container(
        child: notificationsPage(context),


      )
    );
  }
}

Widget notificationsPage(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder(
        future: _getNotifications(),
          builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                MyNotification notification = snapshot.data[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 5.0),
                  child: NotificationTile(body: notification.body, title: notification.title),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
// }

Future<List<MyNotification>> _getNotifications() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //call to a remote file
        final response = await http.get('https://app.lttwchurch.org/getNewNotifications.php');
        //decode to json
        final usersResponse = json.decode(response.body);
        //loop throught an array of data
        for (var item in usersResponse) {
          final notification = MyNotification.fromJsonLocal(item);

          if (await _needToAdd(id: notification.id) == true) {
            await _save(
                myId: notification.id,
                title: notification.title,
                body: notification.body
            );
          }
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
    
    NotificaionDatabaseHelper helper = NotificaionDatabaseHelper.instance;
    List<MyNotification> list = await helper.queryAllNotifications();
    return list;
  }


  _needToAdd({id: int}) async {
    NotificaionDatabaseHelper helper = NotificaionDatabaseHelper.instance;
    MyNotification notification = await helper.queryNotification(id);
    if (notification == null) {
      return true;
    } else {
      return false;
    }
  }

  _save(
      {myId: int,
      title: String,
      body: String}) async {
    MyNotification notification = MyNotification();
    notification.id = myId;
    notification.title = title;
    notification.body = body;
    NotificaionDatabaseHelper helper = NotificaionDatabaseHelper.instance;
    print(notification);
    await helper.insert(notification);
  }