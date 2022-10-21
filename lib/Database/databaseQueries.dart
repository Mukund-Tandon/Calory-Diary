import 'package:calory/Database/basic_data_database.dart';
import 'package:calory/Database/database.dart';
import 'package:calory/Database/local_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

Future<void> InsertRow(String date, String day) async {
  print('inserstart');

  // Database? db= await LocalDatabase.instance.database;
  Database? db = await LocalDatabaseCreate.instance.database();
  await db!.rawQuery('''
        INSERT INTO data (breakfast,lunch,dinner,calorieintake,calorieburned,date,day,timestamp) VALUES (0,0,0,0,0,'$date','$day',CURRENT_TIMESTAMP)
        ''');
  print('done');

  List<Map> list = await db.rawQuery('SELECT * FROM data');
  debugPrint(list.toString());
  print('inserend');
}

Future<List<Map>> GetRow(String date) async {
  // Database? db= await LocalDatabase.instance.database;
  Database? db = await LocalDatabaseCreate.instance.database();
  ;
  List<Map> list = [];
  list = await db!.rawQuery('''
       SELECT * FROM data WHERE date ='$date'
       ''');
  return list;
}

Future<void> UpdateRow(String columnName, String date, int value) async {
  Database? db = await LocalDatabaseCreate.instance.database();
  await db!.rawQuery('''
   UPDATE data SET $columnName = $value WHERE date='$date'
   ''');
}

Future<void> DeleteTable() async {
  print('delstart');
  Database? db = await LocalDatabaseCreate.instance.database();
  await db!.rawQuery('''
  DROP TABLE data
  ''');
  print('end');
}

Future<List<Map>> chartData() async {
  Database? db = await LocalDatabaseCreate.instance.database();
  List<Map> kk = await db!.rawQuery('''SELECT * FROM data''');
  List<Map> list = await db.rawQuery('''
    SELECT * FROM data ORDER BY timestamp DESC LIMIT 10
    ''');
  print(kk);
  print('gg');
  print(list);
  return list;
}

Future<void> InsertRowBasic() async {
  print('inserstart');

  Database? db = await LocalDatabaseCreate.instance.database();
  await db!.rawQuery('''
        INSERT INTO basicdata (height,weight,age,activity,gender,name) VALUES (0,0,0,0,'','basicdata')
        ''');
  print('done');

  List<Map> list = await db.rawQuery('SELECT * FROM basicdata');
  debugPrint(list.toString());
  print('inserend');
}

Future<List<Map>> GetRowBasic() async {
  Database? db = await LocalDatabaseCreate.instance.database();
  List<Map> list = await db!.rawQuery('''
       SELECT * FROM basicdata WHERE name ='basicdata'
       ''');
  return list;
}

Future<void> UpdateRowINTBasic(String columnName, int value) async {
  Database? db = await LocalDatabaseCreate.instance.database();
  await db!.rawQuery('''
   UPDATE basicdata SET $columnName = $value WHERE name='basicdata'
   ''');
}

Future<void> UpdateRowSTRINGBasic(String columnName, String value) async {
  Database? db = await LocalDatabaseCreate.instance.database();
  await db!.rawQuery('''
   UPDATE basicdata SET $columnName = '$value' WHERE name='basicdata'
   ''');
}

Future<void> InsertNewMealDta(
    String meal, int amount, int calory, String name) async {
  Database? db = await LocalDatabaseCreate.instance.database();
  var date =
      "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
  await db!.rawQuery('''
        INSERT INTO caloryIntake (amount,calory,date,name,meal) VALUES ($amount,$calory,'$date','$name','$meal')
        ''');
}

Future<List<Map>> GetMealDtaForTheDay(String meal) async {
  List<Map> l = [];
  Database? db = await LocalDatabaseCreate.instance.database();
  var date =
      "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
  l = await db!.rawQuery("""
   SELECT * FROM caloryIntake WHERE date = '$date' AND meal = '$meal'
   """);
  print('llll $l');
  return l;
}
