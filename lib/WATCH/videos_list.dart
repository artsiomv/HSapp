import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:hsapp/networking/video_network.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'video_list_tile.dart';
import 'package:hsapp/WATCH/video_details_screen.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class VideosList extends StatefulWidget {
  VideosList({Key key}) : super(key: key);

  @override
  _VideosListState createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Text('Watch'),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getVideos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                Video video = snapshot.data[index];
                return Card(
                  margin:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                  child: VideoListTile(
                    video: video,
                    action: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoDetailsScreen(video: video)
                        )
                      );
                    },
                  ));
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future<List<Video>> _getVideos() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //call to a remote file
        final response = await http.get('https://app.lttwchurch.org/messages.php');
        //decode to json
        final usersResponse = json.decode(response.body);
        //loop throught an array of data
        for (var item in usersResponse) {
          final video = Video.fromJsonLocal(item);

          if (await _needToAdd(id: video.id) == true) {
            await _save(
                myId: video.id,
                title: video.title,
                videoURL: video.videoURL,
                imageName: video.imageName,
                speaker: video.speaker,
                dateSpoken: video.dateSpoken
            );
          }
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
    VideoDatabaseHelper helper = VideoDatabaseHelper.instance;
    List<Video> list;
    list = await helper.queryAllVideos();

    return list;
  }

  Future<List<Video>> getLocalVideos() async {
    VideoDatabaseHelper helper = VideoDatabaseHelper.instance;
    List<Video> list = await helper.queryAllVideos();
    return list;
  }

  _needToAdd({id: int}) async {
    VideoDatabaseHelper helper = VideoDatabaseHelper.instance;
    Video video = await helper.queryVideo(id);
    if (video == null) {
      return true;
    } else {
      return false;
    }
  }

  _save(
      {myId: int,
      title: String,
      videoURL: String,
      imageName: String,
      speaker: String,
      dateSpoken: String
      }) async {
    Video video = Video();
    video.id = myId;
    video.title = title;
    video.videoURL = videoURL;
    video.imageName = imageName;
    video.speaker = speaker;
    video.dateSpoken = dateSpoken;
    VideoDatabaseHelper helper = VideoDatabaseHelper.instance;
    print(video);
    await helper.insert(video);
  }
}
