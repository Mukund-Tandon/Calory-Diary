import 'package:flutter/material.dart';
import 'package:calory/Utilities/deviceData.dart';
import 'package:calory/Utilities/constants.dart';
class Container_style extends StatelessWidget {
  Container_style({ required this.colour,required this.childcard,required this.onPress,required this.context});
  final Color colour;
  final Widget childcard;
  final Function onPress;
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPress();
      },
      child: Container(
        height: (131/640)*displayHeight(context),
        width: (129/360)*displayWidth(context),
        child: childcard,
        margin: EdgeInsets.only(top: 30,left: 15,right: 15),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [kboxShadow]

        ),

      ),
    );
  }
}