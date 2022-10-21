import 'package:calory/Database/databaseQueries.dart';
import 'package:flutter/material.dart';
import 'package:calory/Utilities/deviceData.dart';
import 'package:calory/Utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FirstShownHeight extends StatefulWidget {
  const FirstShownHeight({Key? key}) : super(key: key);

  @override
  _FirstShownHeightState createState() => _FirstShownHeightState();
}

class _FirstShownHeightState extends State<FirstShownHeight> {
  int firstheight=1;
  Future<void> setData(int height)async{
    UpdateRowINTBasic('height', height);
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
            Text('Height',
              style: xcontainer_text_style,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:  CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(firstheight.toString(),style: xhieght_container_text_style ),
                Text('cm', style: xhieght_container_unit_text_style,)
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
                value: firstheight.toDouble(),
                min: 1.0,
                max: 200.0,
                onChanged: (double newValue)async{
                  setState(() {
                    firstheight = newValue.round();
                  });
                  await setData(firstheight);
                },
              ),
            )
          ],
        ),
      ),
    );

  }
}
