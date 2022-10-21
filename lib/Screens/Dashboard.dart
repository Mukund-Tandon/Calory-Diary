import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:math';
import 'package:calory/Utilities/deviceData.dart';
import 'package:calory/Utilities/constants.dart';
import 'package:calory/Widgets/meter.dart';
import 'package:calory/Database/databaseQueries.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calory/Utilities/functions/calculate_calories_intake.dart';
import 'package:calory/Widgets/chart.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var current_datetime = DateTime.now();
  var formatedDate =
      "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
  int calorie_Intake_val = 0;
  int calorie_intake_max = 1800;
  int calorie_burned_val = 0;
  int calorie_burned_max = 500;
  String? bmival = '0';
  String? bmi_status = 'please measure BMI';
  int age = 0;
  int weight = 0;
  int activity = 0;
  String gender = '';
  int height = 0;
  int waterIntake = 0;

  Future<void> newRow() async {
    final prefs = await SharedPreferences.getInstance();
    String? prefDate = prefs.getString('prefDate');
    setState(() {
      bmival = prefs.getString('bmival');
      bmi_status = prefs.getString('bmistatus');
    });

    print(prefDate);
    print(formatedDate);
    if (prefDate == Null || prefDate != formatedDate) {
      print('done');
      await prefs.setString('prefDate', formatedDate);
      print(prefDate);
      await InsertRow(formatedDate, (DateTime.now().day).toString());
    }
  }

  Future<void> GetData() async {
    print('getstart');
    List<Map>? list = await GetRow(formatedDate);
    List<Map> basicDataList = await GetRowBasic();
    age = (basicDataList[0])['age'];
    print(age);
    weight = (basicDataList[0])['weight'];
    print(weight);
    height = (basicDataList[0])['height'];
    print(height);
    activity = (basicDataList[0])['activity'];
    print(activity);
    gender = (basicDataList[0])['gender'];
    print(gender);

    setState(() {
      print('done1');
      calorie_Intake_val =
          ((list[0])['breakfast'] + (list[0])['lunch'] + (list[0])['dinner']);
      print('done1');
      calorie_burned_val = (list[0]['calorieburned']);
      print('done1');
    });
  }

  void setData() {
    setState(() {
      print('done1');
      calorie_intake_max = CalorieIntake(age, weight, height, activity, gender);
      print('done1');
    });
  }

  void InitActivity() async {
    await newRow();
    await GetData();
    setData();
  }

// void Deletetable()async{
//   print('start');
//   await DeleteTable();
// }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InitActivity();
    // Deletetable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2F1FA),
      // bottomNavigationBar: navigationBar(context),
      body: SafeArea(
        child: Column(
          children: [
            //Date Text
            Container(
              height: 50,
              width: 91,
              child: Column(
                children: [
                  Container(
                    child: Text(
                      'Today',
                      style: TextStyle(
                        fontFamily: 'Palaquin',
                        fontSize: 18,
                      ),
                    ),
                    height: 28,
                    width: 62,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      '${current_datetime.day}-${current_datetime.month}-${current_datetime.year}',
                      style: TextStyle(
                        fontFamily: 'Palaquin',
                        fontSize: 14,
                      ),
                    ),
                    height: 22,
                    width: 120,
                  )
                ],
              ),
            ),
            //Chart
            Container(
              width: displayWidth(context) * (330 / 360),
              height: displayHeight(context) * (187 / 640),
              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Chart(),
            ),
            // Meter
            Container(
              width: displayWidth(context),
              height: 150,
              margin: EdgeInsets.only(top: 35),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Stack(children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: meter(
                            name: 'Calorie Intake',
                            current_val: calorie_Intake_val,
                            max: calorie_intake_max,
                            width_of_device: displayWidth(context),
                          )),
                    ),
                    Positioned(
                      left: 10,
                      top: 5,
                      child: Container(
                        height: 130,
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 27,
                              child: Text(
                                'Calorie Intake',
                                style: TextStyle(
                                  fontFamily: 'Palaquin',
                                  fontSize: (14 / 640) * displayHeight(context),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '(kcal)',
                                style: TextStyle(
                                  fontFamily: 'Palaquin',
                                  fontSize: (9 / 640) * displayHeight(context),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '$calorie_Intake_val / $calorie_intake_max',
                                style: TextStyle(
                                  fontFamily: 'Palaquin',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Color(0xff9E9E9E),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    width: (65.4 / 411.4) * displayWidth(context),
                  ),
                  Stack(children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: meter(
                            name: 'Calorie Burned',
                            current_val: calorie_burned_val,
                            max: calorie_burned_max,
                            width_of_device: displayWidth(context),
                          )),
                    ),
                    Positioned(
                      left: 10,
                      top: 5,
                      child: Container(
                        height: 130,
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 27,
                              child: Text(
                                'Calorie Burned',
                                style: TextStyle(
                                  fontFamily: 'Palaquin',
                                  fontSize:
                                      (13.4 / 640) * displayHeight(context),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '(kcal)',
                                style: TextStyle(
                                  fontFamily: 'Palaquin',
                                  fontSize: (9 / 640) * displayHeight(context),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '$calorie_burned_val / $calorie_burned_max',
                                style: TextStyle(
                                  fontFamily: 'Palaquin',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Color(0xff9E9E9E),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            //Water intake BMI
            Container(
              height: (155 / 640) * displayHeight(context),
              margin: EdgeInsets.only(top: 35, left: 25, right: 25),
              child: Row(
                children: [
                  //Water Intake
                  //todo - water intake
                  Container(
                    width: displayWidth(context) * (134 / 360),
                    height: displayHeight(context) * (131 / 640),
                    // margin: EdgeInsets.only(left: 15,right: 15, top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: kshadow_color,
                            blurRadius: k_shadow_blur_radius,
                            spreadRadius: k_shadow_spread_radius,
                          )
                        ]),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            'Water Intake',
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: (18 / 640) * displayHeight(context),
                              color: Color(0xff939393),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  '${waterIntake.toString()}',
                                  style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontSize:
                                        (36 / 640) * displayHeight(context),
                                    color: Color(0xff486B65),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'glasses',
                                  style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 45,
                                alignment: Alignment.center,
                                child: FloatingActionButton(
                                  elevation: 0,
                                  backgroundColor: Color(0xffB1FAF5),
                                  child: Icon(Icons.exposure_minus_1),
                                  onPressed: () {
                                    setState(() {
                                      waterIntake--;
                                      if (waterIntake < 0) {
                                        waterIntake = 0;
                                      }
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: (30 / 411.4) * displayWidth(context),
                              ),
                              Container(
                                width: 45,
                                alignment: Alignment.center,
                                child: FloatingActionButton(
                                  elevation: 0,
                                  backgroundColor: Color(0xffB1FAF5),
                                  child: Icon(Icons.plus_one_outlined),
                                  onPressed: () {
                                    setState(() {
                                      waterIntake++;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: (48 / 360) * displayWidth(context),
                  ),
                  //BMI
                  Container(
                    width: displayWidth(context) * (134 / 360),
                    height: displayHeight(context) * (131 / 640),
                    // margin: EdgeInsets.only(left: 15,right: 15, top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: kshadow_color,
                            blurRadius: k_shadow_blur_radius,
                            spreadRadius: k_shadow_spread_radius,
                          )
                        ]),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            'Current BMI',
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: (18 / 640) * displayHeight(context),
                              color: Color(0xff939393),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '$bmival',
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: (36 / 640) * displayHeight(context),
                              color: Color(0xff486B65),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '$bmi_status',
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: (10 / 640) * displayHeight(context),
                              color: Color(0xff7D7D7D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
