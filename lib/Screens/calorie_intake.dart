import 'package:calory/Utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:calory/Utilities/deviceData.dart';
import 'package:calory/Model/calorie_intake_container_list.dart';
import 'package:calory/Model/calorie_intake_itemlist_tile.dart';
import 'package:calory/Model/calorie_intake_itemlist.dart';
import 'package:flutter/services.dart';
import 'package:calory/Database/databaseQueries.dart';

class CalorieIntakeScreen extends StatefulWidget {
  @override
  _CalorieIntakeScreenState createState() => _CalorieIntakeScreenState();
}

class _CalorieIntakeScreenState extends State<CalorieIntakeScreen> {
  int meal = 0;
  String meal_name = '';
  int amount = 0;
  double calories = 0;
  bool loading = false;
  List<CalorieIntakeItemList> calorieIntakeItemlistBreakfast = [];
  List<CalorieIntakeItemList> calorieIntakeItemlistLunch = [];
  List<CalorieIntakeItemList> calorieIntakeItemlistDinner = [];
  final text_field_controller_FoodItem = TextEditingController();
  final text_field_controller_Amount = TextEditingController();
  final text_field_controller_Calorie = TextEditingController();
  void change_mealcard_color(int index) async {
    // loading = true;
    setState(() {
      for (int i = 0; i < calorie_intake_container_list.length; i++) {
        meal = index;
        if (i == index) {
          calorie_intake_container_list[i].isSlected = true;
        } else {
          calorie_intake_container_list[i].isSlected = false;
        }
      }
    });
    // String m;
    // if (meal == 1) {
    //   m = 'lunch';
    // } else if (meal == 2) {
    //   m = 'dinner';
    // } else {
    //   m = 'breakfast';
    // }
    // await newMealLoaded(m);
    // setState(() {
    //   loading = false;
    // });
  }

  newMealLoaded(String m) async {
    List<Map> data = await GetMealDtaForTheDay(m);
    if (m == 'breakfast') {
      data.forEach((element) {
        calorieIntakeItemlistBreakfast.add(CalorieIntakeItemList(
            text: element['name'],
            amount: element['amount'],
            calorie: element['calory'].toDouble()));
      });
    } else if (m == 'lunch') {
      data.forEach((element) {
        calorieIntakeItemlistLunch.add(CalorieIntakeItemList(
            text: element['name'],
            amount: element['amount'],
            calorie: element['calory'].toDouble()));
      });
    } else {
      data.forEach((element) {
        calorieIntakeItemlistDinner.add(CalorieIntakeItemList(
            text: element['name'],
            amount: element['amount'],
            calorie: element['calory'].toDouble()));
      });
    }
  }

  doInitialTask() async {
    List<Map> data = await GetMealDtaForTheDay('breakfast');
    data.forEach((element) {
      calorieIntakeItemlistBreakfast.add(CalorieIntakeItemList(
          text: element['name'],
          amount: element['amount'],
          calorie: element['calory'].toDouble()));
    });
    data = await GetMealDtaForTheDay('lunch');
    data.forEach((element) {
      calorieIntakeItemlistLunch.add(CalorieIntakeItemList(
          text: element['name'],
          amount: element['amount'],
          calorie: element['calory'].toDouble()));
    });
    data = await GetMealDtaForTheDay('dinner');
    data.forEach((element) {
      calorieIntakeItemlistDinner.add(CalorieIntakeItemList(
          text: element['name'],
          amount: element['amount'],
          calorie: element['calory'].toDouble()));
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    loading = true;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      doInitialTask();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbackground_color,
        body: SafeArea(
          child: loading
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 34,
                          child: Text(
                            'Calorie Intake',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Oswald',
                              color: Color(0xff696767),
                            ),
                          ),
                        ),
                        Container(
                          height: (117 / 640) * displayHeight(context),
                          width: (324 / 360) * displayWidth(context),
                          margin: EdgeInsets.only(
                              left: 16,
                              top: (28 / 640) * displayHeight(context),
                              right: 11),
                          // color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: calorie_intake_container_list.map((e) {
                              var index =
                                  calorie_intake_container_list.indexOf(e);
                              return GestureDetector(
                                onTap: () {
                                  change_mealcard_color(index);
                                },

                                //meal cards
                                child: Container(
                                  height: (107 / 640) * displayHeight(context),
                                  width: (100 / 360) * displayWidth(context),
                                  margin: EdgeInsets.only(right: 9),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: kshadow_color,
                                          blurRadius: e.isSlected
                                              ? 0
                                              : k_shadow_blur_radius,
                                          spreadRadius: e.isSlected
                                              ? 0
                                              : k_shadow_spread_radius,
                                        )
                                      ],
                                      color: e.isSlected
                                          ? Color(0xffDFDCDC)
                                          : Colors.white),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            (16 / 640) * displayHeight(context),
                                      ),
                                      Container(
                                        height:
                                            (62 / 640) * displayHeight(context),
                                        width:
                                            (63 / 360) * displayWidth(context),
                                        child: Image.asset('${e.image_path}'),
                                      ),
                                      Container(
                                        child: Text(
                                          '${e.text}',
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontFamily: 'Oswald',
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
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
                              controller: text_field_controller_FoodItem,
                              onChanged: (text) {
                                meal_name = text;
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
                                hintText: 'Food Item',
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: TextField(
                                    controller: text_field_controller_Amount,
                                    onChanged: (text) {
                                      amount = int.parse(text);
                                    },
                                    cursorColor: Color(0xff858181),
                                    cursorHeight:
                                        (30 / 640) * displayHeight(context),
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize:
                                          (18 / 640) * displayHeight(context),
                                      color: Color(0xff858181),
                                    ),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: 'Amount',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize:
                                            (18 / 640) * displayHeight(context),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: TextField(
                                    controller: text_field_controller_Calorie,
                                    onChanged: (text) {
                                      calories = int.parse(text).toDouble();
                                    },
                                    cursorColor: Color(0xff858181),
                                    cursorHeight:
                                        (30 / 640) * displayHeight(context),
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize:
                                          (18 / 640) * displayHeight(context),
                                      color: Color(0xff858181),
                                    ),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: 'Calories',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize:
                                            (18 / 640) * displayHeight(context),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
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
                              itemCount: meal == 0
                                  ? calorieIntakeItemlistBreakfast.length
                                  : meal == 1
                                      ? calorieIntakeItemlistLunch.length
                                      : calorieIntakeItemlistDinner.length,
                              itemBuilder: (context, index) {
                                return CalorieIntakeItemlistTile(
                                  text:
                                      '${meal == 0 ? calorieIntakeItemlistBreakfast[index].text : meal == 1 ? calorieIntakeItemlistLunch[index].text : calorieIntakeItemlistDinner[index].text}',
                                  amount: meal == 0
                                      ? calorieIntakeItemlistBreakfast[index]
                                          .amount
                                      : meal == 1
                                          ? calorieIntakeItemlistLunch[index]
                                              .amount
                                          : calorieIntakeItemlistDinner[index]
                                              .amount,
                                  calories: meal == 0
                                      ? calorieIntakeItemlistBreakfast[index]
                                          .calorie
                                      : meal == 1
                                          ? calorieIntakeItemlistLunch[index]
                                              .calorie
                                          : calorieIntakeItemlistDinner[index]
                                              .calorie,
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ),
        ));
  }

  Future<int> AddCalorie(int amount, int calorie, String mealName) async {
    int val = await currentValue(mealName);
    int sum = val + (amount * calorie);

    return sum;
  }

  Future<int> currentValue(String mealName) async {
    List<Map>? list = await GetRow(kformatedDate);
    int current_val = await (list[0])['$mealName'];
    return current_val;
  }

  Future<void> gestureAction() async {
    if (meal == 0) {
      calorieIntakeItemlistBreakfast.add(CalorieIntakeItemList(
          text: meal_name, amount: amount, calorie: calories));
      int value = await AddCalorie(amount, calories.round(), 'breakfast');
      await InsertNewMealDta('breakfast', amount, calories.round(), meal_name);
      await UpdateRow('breakfast', kformatedDate, value);
    } else if (meal == 1) {
      calorieIntakeItemlistLunch.add(CalorieIntakeItemList(
          text: meal_name, amount: amount, calorie: calories));
      int value = await AddCalorie(amount, calories.round(), 'lunch');
      await InsertNewMealDta('lunch', amount, calories.round(), meal_name);

      await UpdateRow('lunch', kformatedDate, value);
    } else if (meal == 2) {
      calorieIntakeItemlistDinner.add(CalorieIntakeItemList(
          text: meal_name, amount: amount, calorie: calories));
      int value = await AddCalorie(amount, calories.round(), 'dinner');
      await InsertNewMealDta('dinner', amount, calories.round(), meal_name);

      await UpdateRow('dinner', kformatedDate, value);
    }
    text_field_controller_FoodItem.clear();
    text_field_controller_Amount.clear();
    text_field_controller_Calorie.clear();
    setState(() {});
  }
}
