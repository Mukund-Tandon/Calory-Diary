import 'package:flutter/material.dart';
import 'package:calory/Utilities/deviceData.dart';
import 'package:calory/Utilities/constants.dart';
class EntryScreenCard extends StatelessWidget {
  String imagePath;
  String textA;
  String textB;
  String iconPath;
  BuildContext context;
  int left_allign;
  int top_align;
  EntryScreenCard({this.textA='',this.imagePath='',required this.context,this.textB='',this.iconPath='',this.left_allign=0,this.top_align=0});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (248/360)*displayWidth(context),
      height: (169/640)*displayHeight(context),
      margin: EdgeInsets.only(left: 25),
      child: Stack(
        children: [
          Container(
            height: (159/640)*displayHeight(context),
            width: (205/360)*displayWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(65),topLeft:  Radius.circular(12),bottomRight:  Radius.circular(12),bottomLeft:  Radius.circular(12)),
              boxShadow: [
                kboxShadow
              ],
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    '$textA',
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Oswald',
                      color: Color(0xff0E5F64)
                    ),
                  ),
                  margin: EdgeInsets.only(left: 17,top: 22),
                ),
                Container(
                  child: Text(
                    '$textB',
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Oswald',
                        color: Color(0xff0E5F64)
                    ),
                  ),
                  margin: EdgeInsets.only(left: 17),
                ),
                Container(
                  child: Image.asset('$iconPath',scale: .85,),
                  margin: EdgeInsets.only(left: 27,top: 20),
                ),

              ],
            ),
          ),
          Positioned(
            left :left_allign.toDouble(),
            top: top_align.toDouble(),
            child: Container(
              child: Image.asset('$imagePath',scale: .89,),
            ),
          )
        ],
      ),
    );
  }
}
