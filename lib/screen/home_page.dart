import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flip_gesture/utils/constant_color.dart';
import 'package:flip_gesture/utils/constant_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../main.dart';
import '../models/news_data.dart';
import 'page_view.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool liked = false;
  bool disliked = false;
  List<RssData> rssDataList = new List<RssData>();
  final databaseReference = FirebaseDatabase.instance.reference();
  PageController _controller = PageController(
    initialPage: 0,
  );

  Future<DataSnapshot> getData() async {
    await databaseReference.child('rss').once().then((value) {
      setState(() {
        data = value;
        for (int i = 0; i < data.value.length; i++) {
          RssData rssData = new RssData();
          rssData.link = data.value[i][linkText];
          rssData.description = data.value[i][descriptionText];
          rssData.title = data.value[i][titleText];
          rssData.url = data.value[i][urlText];
          rssData.like_count = data.value[i][likeCountText];
          rssData.dislike_count = data.value[i][dislikeCountText];
          rssDataList.add(rssData);
        }
        // for (int i = 0; i < rssDataList.length; i++) {
        //   databaseReference.child('rss/$i').child('liked').remove();
        //   databaseReference.child('rss/$i').child('dislike').remove();
        // }
        debugPrint(value.toString());
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarData(),
      body: data != null
          ? WillPopScope(onWillPop: _onWillPop, child: pageBuilder())
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(dialogTitle),
            content: Text(closeAppQue),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(noText),
              ),
              FlatButton(
                onPressed: () => exit(0),
                child: Text(yesText),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget appBarData() {
    return AppBar(
      backgroundColor: mainColor,
      title: Text(
        feedText,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      centerTitle: true,
    );
  }

  Widget pageBuilder() {
    return PageView.builder(
      itemCount: rssDataList.length,
      scrollDirection: Axis.vertical,
      controller: _controller,
      itemBuilder: (context, index) {
        return pagination(index);
      },
    );
  }

  Widget pagination(int index) {
    String swipeDirection;
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity > 0) {
          print(dislikedPostText);

          disliked
              ? null
              : setState(() {
                  databaseReference.child('rss/${index}').update(
                      {dislikeCountText: rssDataList[index].dislike_count + 1});
                  rssDataList[index].dislike_count =
                      rssDataList[index].dislike_count + 1;
                  disliked = true;
                  _controller.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                });
        } else if (details.primaryVelocity < 0) {
          print(likedPostText);

          liked
              ? null
              : setState(() {
                  databaseReference.child('rss/${index}').update(
                      {likeCountText: rssDataList[index].like_count + 1});
                  rssDataList[index].like_count =
                      rssDataList[index].like_count + 1;
                  liked = true;
                  _controller.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                });
        }
      },
      child: PageViewData(
        controller: _controller,
        index: index,
        reference: databaseReference,
        data: rssDataList,
        liked: liked,
        disliked: disliked,
      ),
    );
  }
}
