import 'package:calory/Database/databaseQueries.dart';
import 'package:calory/Utilities/deviceData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool loading = false;
  int caloryIntake = 0;
  int caloryBurned = 0;
  int breakfast = 0;
  int lunch = 0;
  int dinner = 0;
  bool nulldata = false;
  void getDataFromDate(String date) async {
    setState(() {
      loading = true;
    });
    List<Map> data = [];
    data = await GetRow(date);
    if (data.isEmpty) {
      nulldata = true;
    } else {
      nulldata = false;
      caloryBurned = data[0]['calorieburned'];
      breakfast = data[0]['breakfast'];
      lunch = data[0]['lunch'];
      dinner = data[0]['dinner'];
      caloryIntake = breakfast + lunch + dinner;
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    var date =
        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getDataFromDate(date);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Color(0xffE2F1FA),
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: SfCalendar(
                    view: CalendarView.month,
                    showDatePickerButton: true,
                    showNavigationArrow: true,
                    onTap: (CalendarTapDetails details) {
                      DateTime date = details.date!;
                      String d = '${date.day}-${date.month}-${date.year}';
                      getDataFromDate(d);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: (5 / 640) * displayHeight(context),
                  width: displayWidth(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: (32 / 360) * displayWidth(context)),
                  child: Divider(
                    thickness: (5 / 640) * displayHeight(context),
                    color: Colors.white,
                  ),
                ),
                Container(
                  child: Text(
                    'Data',
                    style: TextStyle(
                      fontSize: (18 / 640) * displayHeight(context),
                      fontFamily: 'Oswald',
                    ),
                  ),
                ),
                loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : nulldata
                        ? Center(
                            child: Text(
                              'No Data of this date',
                              style: TextStyle(
                                fontSize: (18 / 640) * displayHeight(context),
                                fontFamily: 'Oswald',
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Calory Intake',
                                          style: TextStyle(
                                            fontSize: (18 / 640) *
                                                displayHeight(context),
                                            fontFamily: 'Oswald',
                                          ),
                                        ),
                                        Text(
                                          caloryIntake.toString(),
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: (16 / 640) *
                                                displayHeight(context),
                                            fontFamily: 'Oswald',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Text(
                                          'Calory Burned',
                                          style: TextStyle(
                                            fontSize: (16 / 640) *
                                                displayHeight(context),
                                            fontFamily: 'Oswald',
                                          ),
                                        ),
                                        Text(
                                          caloryBurned.toString(),
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: (14 / 640) *
                                                displayHeight(context),
                                            fontFamily: 'Oswald',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Breakfast',
                                          style: TextStyle(
                                            fontSize: (16 / 640) *
                                                displayHeight(context),
                                            fontFamily: 'Oswald',
                                          ),
                                        ),
                                        Text(
                                          breakfast.toString(),
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: (14 / 640) *
                                                displayHeight(context),
                                            fontFamily: 'Oswald',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Text(
                                          'Lunch',
                                          style: TextStyle(
                                            fontSize: (16 / 640) *
                                                displayHeight(context),
                                            fontFamily: 'Oswald',
                                          ),
                                        ),
                                        Text(
                                          lunch.toString(),
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: (14 / 640) *
                                                displayHeight(context),
                                            fontFamily: 'Oswald',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Text(
                                          'Dinner',
                                          style: TextStyle(
                                            fontSize: (16 / 640) *
                                                displayHeight(context),
                                            fontFamily: 'Oswald',
                                          ),
                                        ),
                                        Text(
                                          dinner.toString(),
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: (14 / 640) *
                                                displayHeight(context),
                                            fontFamily: 'Oswald',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
