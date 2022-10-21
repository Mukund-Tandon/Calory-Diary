import 'package:calory/Utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:calory/Utilities/deviceData.dart';
import 'package:calory/Model/calorie_intake_container_list.dart';
import 'package:calory/Model/calorie_intake_itemlist_tile.dart';
import 'package:calory/Model/calorie_intake_itemlist.dart';
import 'package:flutter/services.dart';
import 'package:calory/Database/databaseQueries.dart';

class CalorieBurned extends StatefulWidget {
  @override
  _CalorieBurnedState createState() => _CalorieBurnedState();
}

class _CalorieBurnedState extends State<CalorieBurned> {
  String excercise_name = '';
  int sets = 0;
  double calories = 0;
  final text_field_controller_Excersice = TextEditingController();
  final text_field_controller_sets = TextEditingController();
  final text_field_controller_Calorie = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbackground_color,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 34,
                    child: Text(
                      'Calorie Burned',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Oswald',
                        color: Color(0xff696767),
                      ),
                    ),
                  ),

                  Container(
                    alignment: Alignment.center,
                    height: (42 / 640) * displayHeight(context),
                    width: (328 / 360) * displayWidth(context),
                    margin: EdgeInsets.only(
                        left: (16 / 360) * displayWidth(context),
                        right: (16 / 360) * displayWidth(context),
                        top: (37 / 640) * displayHeight(context)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [kboxShadow],
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 120),
                      child: TextField(
                        controller: text_field_controller_Excersice,
                        onChanged: (text) {
                          excercise_name = text;
                        },
                        cursorColor: Color(0xff858181),
                        cursorHeight: (30 / 640) * displayHeight(context),
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: (18 / 640) * displayHeight(context),
                          color: Color(0xff858181),
                        ),
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Exercise',
                          hintStyle: TextStyle(
                            fontFamily: 'Oswald',
                            fontSize: (18 / 640) * displayHeight(context),
                            color: Color(0xff858181),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Values of amount calorie
                  Container(
                    height: (52 / 640) * displayHeight(context),
                    width: (328 / 360) * displayWidth(context),
                    margin: EdgeInsets.only(
                        left: (16 / 360) * displayWidth(context),
                        right: (16 / 360) * displayWidth(context),
                        top: (19 / 640) * displayHeight(context)),
                    child: Row(
                      children: [
                        Container(
                          height: (42 / 640) * displayHeight(context),
                          width: (143 / 360) * displayWidth(context),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [kboxShadow],
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: TextField(
                              controller: text_field_controller_sets,
                              onChanged: (text) {
                                sets = int.parse(text);
                              },
                              cursorColor: Color(0xff858181),
                              cursorHeight: (30 / 640) * displayHeight(context),
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: (18 / 640) * displayHeight(context),
                                color: Color(0xff858181),
                              ),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Sets',
                                hintStyle: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: (18 / 640) * displayHeight(context),
                                  color: Color(0xff858181),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: (40 / 360) * displayWidth(context),
                        ),
                        Container(
                          height: (42 / 640) * displayHeight(context),
                          width: (143 / 360) * displayWidth(context),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [kboxShadow],
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: TextField(
                              controller: text_field_controller_Calorie,
                              onChanged: (text) {
                                calories = int.parse(text).toDouble();
                              },
                              cursorColor: Color(0xff858181),
                              cursorHeight: (30 / 640) * displayHeight(context),
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: (18 / 640) * displayHeight(context),
                                color: Color(0xff858181),
                              ),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Calories',
                                hintStyle: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: (18 / 640) * displayHeight(context),
                                  color: Color(0xff858181),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Add
                  GestureDetector(
                    onTap: () async {
                      await gestureAction();
                      // setState(() {
                      //   Navigator.pop(context);
                      // });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: (42 / 640) * displayHeight(context),
                      width: (93 / 360) * displayWidth(context),
                      margin: EdgeInsets.only(
                          top: (10 / 640) * displayHeight(context)),
                      decoration: BoxDecoration(
                        color: Color(0xffB1FAF5),
                        boxShadow: [kboxShadow],
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Text(
                        'Add',
                        style: TextStyle(
                            fontFamily: 'Oswald',
                            fontSize: (18 / 640) * displayHeight(context),
                            color: Color(0xff686868)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (19 / 640) * displayHeight(context),
                  ),
                  //divider
                  Container(
                      height: (5 / 640) * displayHeight(context),
                      width: displayWidth(context),
                      padding: EdgeInsets.symmetric(
                          horizontal: (32 / 360) * displayWidth(context)),
                      child: Divider(
                        thickness: (5 / 640) * displayHeight(context),
                        color: Colors.white,
                      )),
                  // Items List
                  Container(
                    child: Text(
                      'Items List',
                      style: TextStyle(
                        fontSize: (18 / 640) * displayHeight(context),
                        fontFamily: 'Oswald',
                      ),
                    ),
                  ),
                  //Item list view
                  Container(
                    height: (160 / 843.4) * displayHeight(context),
                    width: displayWidth(context),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.builder(
                        itemCount: excerciseList.length,
                        itemBuilder: (context, index) {
                          return CalorieIntakeItemlistTile(
                            text: excerciseList[index].text,
                            amount: excerciseList[index].amount,
                            calories: excerciseList[index].calorie,
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  List<CalorieIntakeItemList> excerciseList = [];
  Future<void> gestureAction() async {
    excerciseList.add(CalorieIntakeItemList(
        text: excercise_name, amount: sets, calorie: calories));
    int value = await AddCalorie(sets, calories.round(), 'calorieburned');
    UpdateRow('calorieburned', kformatedDate, value);
    text_field_controller_Excersice.clear();
    text_field_controller_sets.clear();
    text_field_controller_Calorie.clear();
    setState(() {});
  }

  Future<int> AddCalorie(int amount, int calorie, String mealName) async {
    int val = await currentValue(mealName);
    int sum = val + calorie;

    return sum;
  }

  Future<int> currentValue(String mealName) async {
    List<Map>? list = await GetRow(kformatedDate);
    int current_val = await (list[0])['$mealName'];
    return current_val;
  }
}
