import 'package:calory/Widgets/bmi_container.dart';
import 'package:calory/Utilities/constants.dart';
import 'package:calory/Widgets/icon_select_bmi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:calory/Utilities/deviceData.dart';
import 'package:calory/Utilities/functions/calculate_bmi/bmi_status.dart';
import 'package:calory/Utilities/functions/calculate_bmi/bmi_value.dart';
import 'package:calory/Screens/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calory/Database/databaseQueries.dart';

enum Gender {male,female}
Gender x=Gender.female;
void Update_color_gender_card(Gender selected_gender)
{
  if(selected_gender == Gender.male)
  {
    x = Gender.male;
    if(male_color == xnot_selected_container_color)
    {
      male_color = xselected_container_color;
      female_color = xnot_selected_container_color;
    }
    else{
      male_color = xnot_selected_container_color;
    }

  }
  if(selected_gender == Gender.female)
  {
    x = Gender.female;
    if(female_color == xnot_selected_container_color)
    {
      male_color = xnot_selected_container_color;
      female_color = xselected_container_color;
    }
    else{
      female_color = xnot_selected_container_color;
    }
  }
}
class BMIScreen extends StatefulWidget {
  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  int hieght= 1;
  int weight = 1;
  String bmival='';
  String bmistatus= '';
  void sharedpref(String bmival, String bmistatus)async{
    final prefs =await SharedPreferences.getInstance();
    prefs.setString('bmival', bmival);
    prefs.setString('bmistatus', bmistatus);
  }
void getData()async{
    List<Map> list=await GetRowBasic();
    setState(() {
      hieght= (list[0])['height'];
      weight=(list[0])['weight'];
    });

}

  Future<void> setData(int height ,String name)async{
    UpdateRowINTBasic('$name', height);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kbackground_color,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 32,
              child: Text(
                'BMI',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Oswald',
                  color: Color(0xff696767),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container_style(
                    context: context,
                    colour: male_color,
                    onPress: (){
                      setState(() {
                        Update_color_gender_card(Gender.male);
                      });
                    },
                    childcard: Icon_select(icon: FontAwesomeIcons.mars,text: 'MALE',distace_between_icon_and_text: 12.0,icon_size: 100.0,color: Color(0xff70DFED),),
                  ),
                ),
                Expanded(child: Container_style(
                  context: context,
                  colour: female_color,
                  onPress: (){
                    setState(() {
                      Update_color_gender_card(Gender.female);                  });
                  },
                  childcard: Icon_select(icon: FontAwesomeIcons.venus,text: 'FEMALE',distace_between_icon_and_text: 12.0,icon_size: 100.0,color: Color(0xffFF748F),),
                )),
              ],
            ),
              //Hieght slider
              Container(
                height: (114/640)*displayHeight(context),
                width: (301/360)*displayWidth(context),
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                    color: xnot_selected_container_color,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [kboxShadow]

                ),
    child:  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text('Hieght',
    style: xcontainer_text_style,),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment:  CrossAxisAlignment.baseline,
    textBaseline: TextBaseline.alphabetic,
    children: [
    Text(hieght.toString(),style: xhieght_container_text_style ),
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
    value: hieght.toDouble(),
    min: 1.0,
    max: 250.0,
    onChanged: (double newValue)async{
    setState(() {
    hieght = newValue.round();
    });
    await setData(hieght, 'height');
    },
    ),
    )
    ],
    ),
    ),
              Container(
    height: (114/640)*displayHeight(context),
    width: (301/360)*displayWidth(context),
    margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                    color: xnot_selected_container_color,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [kboxShadow]

                ),
    child:  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text('Weight',
    style: xcontainer_text_style,),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment:  CrossAxisAlignment.baseline,
    textBaseline: TextBaseline.alphabetic,
    children: [
    Text(weight.toString(),style: xhieght_container_text_style ),
    Text('kg', style: xhieght_container_unit_text_style,)
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
    value: weight.toDouble(),
    min: 1.0,
    max: 200.0,
    onChanged: (double newValue)async{
    setState(() {
    weight = newValue.round();
    });
    await setData(weight, 'weight');
    },
    ),
    )
    ],
    ),
    ),

            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                bmival = BMIValue(hieght, weight).toStringAsFixed(1);
                bmistatus =  BMIStatus(BMIValue(hieght, weight));
                sharedpref(bmival, bmistatus);
                showDialog(context: context,barrierDismissible: false, builder: (context){
                  return Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: (300/843.4)*displayHeight(context),
                      width: (90/411.4)*displayWidth(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              'Your BMI',
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: (18/640)*displayHeight(context),
                                color: Color(0xff696767)
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            child: Text(
                              '$bmival',
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: (70/843)*displayHeight(context),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              '$bmistatus',
                              style: TextStyle(
                                fontSize: (15/843.4)*displayHeight(context),
                                fontFamily: 'Oswald',
                              ),
                            ),
                          ),
                          Container(

                            width: (290/411.4)*displayWidth(context),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: (60/843.4)*displayHeight(context),
                                    width: (110/411.4)*displayWidth(context),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),

                                        color: Color(0xffB1FAF5)
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Once More',
                                      style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: (18/843.4)*displayHeight(context),
                                        color: Color(0xff686868),
                                      ),
                                    ),

                                  ),
                                ),
                                SizedBox(width: (39/411.4)*displayWidth(context),),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                  },
                                  child: Container(
                                    height: (60/843.4)*displayHeight(context),
                                    width: (110/411.4)*displayWidth(context),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),

                                      color: Color(0xffB1FAF5)
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'HomeScreen',
                                      style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: (18/843.4)*displayHeight(context),
                                        color: Color(0xff686868),
                                      ),
                                    ),

                                  ),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),

                    ),
                  );
                });

              },
              child: Container(
                height: (49/640)*displayHeight(context),
                width: (161/360)*displayWidth(context),
                alignment: Alignment.center,
                child: Text(
                  'Calculate',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 23,
                    color: Color(0xff686868),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xffB1FAF5),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [kboxShadow],
                ),
              ),
            )



          ],
        ),
      ),
    );
  }
}
