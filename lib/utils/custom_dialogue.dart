import 'package:flutter/material.dart';

class CustomDialogueTwoBtn extends StatelessWidget {
  String title;
  String message;
  String firstBtnName;
  VoidCallback firstBtnClick;
  String secondBtnName;
  VoidCallback secondBtnClick;

  CustomDialogueTwoBtn({
    @required this.title,
    @required this.message,
    @required this.firstBtnName,
    @required this.firstBtnClick,
    @required this.secondBtnName,
    @required this.secondBtnClick,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      )),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  )),
              SizedBox(
                height: 35,
              ),
              Text(
                message,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      onPressed: firstBtnClick,
                      child: Text(
                        firstBtnName,
                        style: TextStyle(fontSize: 16),
                      )),
                  FlatButton(
                      onPressed: secondBtnClick,
                      child: Text(
                        secondBtnName,
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}