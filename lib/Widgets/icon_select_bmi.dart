import 'package:calory/Utilities/constants.dart';
import 'package:flutter/material.dart';
class Icon_select extends StatelessWidget {
  Icon_select({required this.icon,required this.text,required this.distace_between_icon_and_text,required this.icon_size,required this.color});
  final IconData icon;
  final String text;
  final double distace_between_icon_and_text;
  final double icon_size;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
          size: icon_size,
        ),
        SizedBox(height: distace_between_icon_and_text),
        Text( text,
          style: xcontainer_text_style,
        ),
      ],
    );
  }
}