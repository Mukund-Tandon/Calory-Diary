import 'package:calory/Screens/calorie_intake.dart';
import 'package:flutter/material.dart';
import 'package:calory/Utilities/deviceData.dart';
import 'package:calory/Utilities/constants.dart';
import 'package:calory/Widgets/customAnimatedBottomBar.dart';
import 'package:calory/Widgets/entry_screen_cards.dart';
import 'package:calory/Screens/calculate_bmi.dart';
import 'package:calory/Screens/calorie_burned.dart';
import 'package:flutter/services.dart';
class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  int _current_index = 1;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
          backgroundColor: Color(0xffE2F1FA),

          body: SafeArea(
            child: Container(
              width: displayWidth(context),
              height: displayHeight(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CalorieIntakeScreen()));
                    },
                    child: EntryScreenCard(
                      context: context,
                      iconPath: 'assets/icons/icons8-next-page-48 3.png',
                      imagePath: 'assets/illustrations/undraw_Hamburger_8ge6 1.png',
                      textA: 'Calorie',
                      textB: 'Intake',
                      left_allign: 85,
                      top_align: 63,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CalorieBurned()));
                    },
                    child: EntryScreenCard(context: context,
                      iconPath: 'assets/icons/icons8-next-page-48 3.png',
                      imagePath: 'assets/illustrations/Group 10.png',
                      textA: 'Calorie',
                      textB: 'Burned',
                      left_allign: 90,
                      top_align: 69,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BMIScreen()));
                    },
                    child: EntryScreenCard(context: context,
                      iconPath: 'assets/icons/icons8-next-page-48 3.png',
                      imagePath: 'assets/illustrations/undraw_Calculator_0evy 1.png',
                      textA: 'Calculate',
                      textB: 'BMI',
                      left_allign: 110,
                      top_align: 60,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

}