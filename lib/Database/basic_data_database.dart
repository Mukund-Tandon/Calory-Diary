import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
class BasicData{
  static final _databaseName = "basicdatadatabase.db";
  static final _databaseVersion = 1;


  static Database? _database;

  BasicData._privateConstructor();
  static final BasicData instance = BasicData._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, '$_databaseName');
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: (db, int )async{
          await db.execute('''
              CREATE TABLE basicdata (
	            uid SERIAL PRIMARY KEY,
              height INTEGER,
              weight INTEGER,
              age INTEGER,
              activity INTEGER,
              gender TEXT,
              name VARCHAR
            )
           ''');
        });
  }




}
