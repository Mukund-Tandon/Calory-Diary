import 'package:flutter/material.dart';
import 'package:calory/Screens/test.dart';
import 'package:calory/Screens/Dashboard.dart';
import 'package:calory/Screens/entryscreen.dart';
import 'package:calory/Screens/homescreen.dart';
import 'package:calory/Widgets/chart.dart';
import 'package:calory/Screens/first_shown_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<int> sharedpref()async{
  int option=1;
  final prefs =await SharedPreferences.getInstance();
  print('done');
  String? opened = prefs.getString('opened');
  print('done');
  if(opened=='true'){
    print('done');
    option= 2;
  }
  else if(opened==null){
    print('done2');
    option=1;
  }
  return option;

}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  print('mainstart');
  int option= await  sharedpref();
  print('done');



  runApp(MyApp(option: option,));
}
class MyApp extends StatelessWidget {
 int option;
 MyApp({this.option=1});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: option==1?FirstShown():HomeScreen(),
    );
  }
}



