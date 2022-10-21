import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:math';
class test extends StatefulWidget {

  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  int val= 0;
  int max_val = 1800;
  List<RemarksModel> reportReasons = [];

  @override
  void initState() {
    super.initState();
    reportReasons = [
      RemarksModel(isSelected: false, reason: 'blah'),
      RemarksModel(isSelected: false, reason: 'blah blah'),
      RemarksModel(isSelected: false, reason: 'blah blah blah')
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Wrap(
          children: reportReasons
              .map((reportReason) => GestureDetector(
        onTap: () {
          setState(() {
            reportReason.isSelected = !reportReason.isSelected;
          });
        },
        child: Container(
          margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.021,
            bottom: MediaQuery.of(context).size.height * 0.009,
          ),
          decoration: BoxDecoration(
              color: reportReason.isSelected
                  ? Color(0xff4aa3f8)
                  : Color(0xff3a327f),
              borderRadius: BorderRadius.circular(12),
              ),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.027,
              vertical:
              MediaQuery.of(context).size.height * 0.0045),
          child: Text(
            reportReason.reason,
            style: TextStyle(
                fontSize: 13.5,
                color: reportReason.isSelected
                    ? Color(0xff231b6a)
                    : null),
          ),
        ),
    ))
    .toList()),
    ),
      ));
  }}


class RemarksModel {
  bool isSelected;
  String reason;

  RemarksModel({required this.isSelected,required this.reason});
}