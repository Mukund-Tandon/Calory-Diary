import 'package:calory/Utilities/deviceData.dart';
import 'package:flutter/material.dart';
class CalorieIntakeItemlistTile extends StatelessWidget {
String text;
int amount;
double calories;
CalorieIntakeItemlistTile({this.text='',this.calories=0,this.amount=0});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: displayWidth(context),
      child: Row(
        children: [
          SingleChildScrollView(
            child: Container(
              width: (100/411.4)*displayWidth(context),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: (18/640)*displayHeight(context),
                  fontFamily: 'Oswald',
                  color: Color(0xff686868),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            child: Text(
              'X$amount',
              style: TextStyle(
                fontSize: (18/640)*displayHeight(context),
                fontFamily: 'Oswald',
                color: Color(0xff686868),
              ),
            ),
          ),
          SizedBox(
            width: (180/411.4)*displayWidth(context),
          ),
          Container(
            child: Text(
              '$calories',
              style: TextStyle(
                fontSize: (18/640)*displayHeight(context),
                fontFamily: 'Oswald',
                color: Color(0xff686868),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
