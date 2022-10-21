import 'package:flutter/material.dart';
import 'package:calory/Widgets/first_shown_age.dart';
import 'package:calory/Widgets/first_shown_height.dart';
import 'package:calory/Widgets/fist_shown_gender.dart';
import 'package:calory/Widgets/firsts_shown_weight.dart';
import 'package:calory/Widgets/first_shown_activity.dart';
import 'package:flutter/services.dart';
import 'package:calory/Utilities/deviceData.dart';
import 'package:calory/Screens/homescreen.dart';
import 'package:calory/Database/databaseQueries.dart';
class FirstShown extends StatefulWidget {

  @override
  _FirstShownState createState() => _FirstShownState();
}

class _FirstShownState extends State<FirstShown> {
  int selectedIndex = 0;
  PageController _pageController = PageController();
  void firstShown()async{
    await InsertRowBasic();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstShown();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: displayHeight(context),
            width: displayWidth(context),
            color: Color(0xffE2F1FA),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: (120/843.4)*displayHeight(context)),
                  height: (580/843.4)*displayHeight(context) ,
                  width: displayWidth(context),
                  child: Container(
                    width: (360/411.4)*displayWidth(context),
                    child: PageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (index){
                        setState(() {
                          selectedIndex= index;
                        });
                      },
                      children: [
                        FirstShownGender(),
                        FirstShownAge(),
                        FirstShownHeight(),
                        FirstShownWeight(),
                        FirstShownActivity(),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: (40/843.4)*displayHeight(context),),
                Container(
                  width: displayWidth(context),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      IgnorePointer(
                        ignoring: selectedIndex>0?false:true,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {

                              _pageController.animateToPage(--selectedIndex, duration: Duration(milliseconds: 200), curve: Curves.linear);
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color:selectedIndex>0? Color(0xffB1FAF5):Colors.transparent,
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            height: (50/843.4)*displayHeight(context),
                            width: (120/411.4)*displayWidth(context),
                            child: Text(
                              'Back',
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: (25/843.4)*displayHeight(context),
                                color:selectedIndex>0 ?Color(0xff686868):Colors.transparent,
                              ),

                            ),

                          ),
                        ),
                      ),
                      SizedBox(width: (120/411.4)*displayWidth(context),),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if(selectedIndex==4){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                            }
                            _pageController.animateToPage(++selectedIndex, duration: Duration(milliseconds: 200), curve: Curves.linear);
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:Color(0xffB1FAF5),
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          height: (50/843.4)*displayHeight(context),
                          width: (120/411.4)*displayWidth(context),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: (25/843.4)*displayHeight(context),
                              color: Color(0xff686868),
                            ),

                          ),

                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
