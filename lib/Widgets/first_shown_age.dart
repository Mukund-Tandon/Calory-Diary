import 'package:calory/Database/databaseQueries.dart';
import 'package:flutter/material.dart';
import 'package:calory/Utilities/deviceData.dart';
import 'package:calory/Utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FirstShownAge extends StatefulWidget {
  const FirstShownAge({Key? key}) : super(key: key);

  @override
  _FirstShownAgeState createState() => _FirstShownAgeState();
}

class _FirstShownAgeState extends State<FirstShownAge> {
  int firstage=1;
  Future<void> setData(int age)async{
    UpdateRowINTBasic('age', age);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffE2F1FA),
      alignment: Alignment.center,
      child: Container(
        height: (114/640)*displayHeight(context),
        width: (301/360)*displayWidth(context),
        margin: EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [kboxShadow]

        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Age',
              style: xcontainer_text_style,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:  CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(firstage.toString(),style: xhieght_container_text_style ),
                Text('', style: xhieght_container_unit_text_style,)
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                  thumbColor: Colors.lightBlue[400],
                  overlayColor: Color(0x2929b6f6),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                  activeTrackColor: Colors.lightBlue,
                  inactiveTrackColor: Colors.grey[500],
                  trackHeight: 3.0
              ),
              child: Slider(
                value: firstage.toDouble(),
                min: 1.0,
                max: 100.0,
                onChanged: (double newValue)async{
                  setState(() {
                    firstage = newValue.round();
                  });
                  await setData(firstage);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
