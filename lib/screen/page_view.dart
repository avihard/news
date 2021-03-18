import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flip_gesture/models/news_data.dart';
import 'package:flip_gesture/screen/webview_screen.dart';
import 'package:flip_gesture/utils/constant_color.dart';
import 'package:flip_gesture/utils/constant_string.dart';
import 'package:flutter/material.dart';

class PageViewData extends StatefulWidget {
  PageController controller;
  int index;
  DatabaseReference reference;
  List<RssData> data;
  bool liked;
  bool disliked;

  PageViewData(
      {this.controller,
      this.index,
      this.reference,
      this.data,
      this.liked,
      this.disliked});
  @override
  _PageViewDataState createState() => _PageViewDataState();
}

class _PageViewDataState extends State<PageViewData> {
  int likeCounts = 0;

  @override
  void initState() {
    widget.liked = false;
    widget.disliked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: tappingEvent(context),
      ),
    );
  }

  Widget tappingEvent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  WebViewScreen(widget.data[widget.index].link),
            ));
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                image(context),
                SizedBox(
                  height: 20,
                ),
                textData(),
                SizedBox(
                  height: 20,
                ),
                htmlView()
              ],
            ),
            Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        child: Container(
                          // padding: EdgeInsets.only(top: 5),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: redColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.cancel_outlined,
                            color: whiteColor,
                            size: 40,
                          ),
                        ),
                        onTap: widget.disliked
                            ? () {}
                            : () {
                                setState(() {
                                  widget.reference
                                      .child('rss/${widget.index}')
                                      .update({
                                    dislikeCountText: widget
                                            .data[widget.index].dislike_count +
                                        1
                                  });
                                  widget.disliked = true;
                                  //widget.data[widget.index].dislike = true;
                                });
                                widget.controller.nextPage(
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              }),
                    InkWell(
                        child: Container(
                          padding: EdgeInsets.only(top: 5),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: greenColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: whiteColor,
                            size: 40,
                          ),
                        ),
                        onTap: widget.liked
                            ? () {}
                            : () {
                                setState(() {
                                  widget.reference
                                      .child('rss/${widget.index}')
                                      .update({
                                    likeCountText:
                                        widget.data[widget.index].like_count + 1
                                  });
                                  widget.data[widget.index].like_count =
                                      widget.data[widget.index].like_count + 1;
                                  widget.liked = true;
                                });
                                widget.controller.nextPage(
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget textData() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Text(
        widget.data[widget.index].title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget image(BuildContext context) {
    return /* Stack(
      children: [*/
        Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height / 2,
      child: CachedNetworkImage(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height / 2,
        fit: BoxFit.cover,
        imageUrl: widget.data[widget.index].url,
        placeholder: (context, url) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget htmlView() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Text(
        widget.data[widget.index].description,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 16, color: blackColor),
      ),
    );
  }
}
