import 'package:calory/Database/databaseQueries.dart';
import 'package:flutter/material.dart';
import 'package:calory/Model/activities_option_list.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calory/Utilities/constants.dart';
class FirstShownActivity extends StatefulWidget {


  @override
  _FirstShownActivityState createState() => _FirstShownActivityState();
}

class _FirstShownActivityState extends State<FirstShownActivity> {

  void change_mealcard_color(int index) {
    for (int i = 0; i < activitylist.length; i++) {

      if (i == index) {
        activitylist[i].isSelected = true;
      }
      else {
        activitylist[i].isSelected = false;
      }
    }
  }

  Future<void> setData(int tile) async {
    UpdateRowINTBasic('activity', tile);
  }

  void setTrue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('opened', 'true');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTrue();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffE2F1FA),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'How active are you?',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Oswald',
                  color: Color(0xff696767),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: activitylist.map((e) {
                  var index = activitylist.indexOf(e);
                  return GestureDetector(
                      onTap: () async {
                        setState(() {
                          GestureActivity(index);
                        });
                        await setData(index);
                      },
                      child: Container(
                        height: 70,
                        width: 330,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: e.isSelected ? Color(0xffDFDCDC) : Colors
                                .white,
                            boxShadow: [kboxShadow],
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: Text(
                          '${e.text}',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Oswald',
                          ),
                        ),
                      ));
                }).toList(),
              ),
            ),
          ],
        )

    );
  }

  void GestureActivity(int index) {
    change_mealcard_color(index);
  }
}
