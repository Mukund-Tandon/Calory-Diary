import 'package:calory/Database/databaseQueries.dart';
import 'package:calory/Widgets/bmi_container.dart';
import 'package:calory/Utilities/constants.dart';
import 'package:calory/Widgets/icon_select_bmi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:calory/Utilities/deviceData.dart';

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
class FirstShownGender extends StatefulWidget {

  @override
  _FirstShownGenderState createState() => _FirstShownGenderState();
}

class _FirstShownGenderState extends State<FirstShownGender> {
  Future<void> setData(String gender)async{
     await UpdateRowSTRINGBasic('gender', gender);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (600/843.3)*displayHeight(context),
      width: (300/360)*displayWidth(context),
      color: Color(0xffE2F1FA),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          Expanded(
            child: Container_style(
              context: context,
              colour: male_color,
              onPress: ()async{
                setState(() {
                  Update_color_gender_card(Gender.male);
                });
                await setData('male');
              },
              childcard: Icon_select(icon: FontAwesomeIcons.mars,text: 'MALE',distace_between_icon_and_text: 12.0,icon_size: 100.0,color: Color(0xff70DFED),),
            ),
          ),
          Expanded(child: Container_style(
            context: context,
            colour: female_color,
            onPress: ()async{
              setState(() {
                Update_color_gender_card(Gender.female);
              });
              await setData('female');
            },
            childcard: Icon_select(icon: FontAwesomeIcons.venus,text: 'FEMALE',distace_between_icon_and_text: 12.0,icon_size: 100.0,color: Color(0xffFF748F),),
          )),
        ],

      ),
    );
  }
}
