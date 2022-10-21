import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseCreate {
  static Database? databaseInstance;

  LocalDatabaseCreate();
  static final LocalDatabaseCreate instance = LocalDatabaseCreate();
  Future<Database?> database() async {
    if (databaseInstance != null) return databaseInstance;
    print('New dtabse !!!');
    databaseInstance = await _initDatabse();

    return databaseInstance;
  }

  _initDatabse() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'ko.db');

    return await openDatabase(dbPath, version: 1, onCreate: populateDb);
  }

  Future<void> populateDb(Database db, int version) async {
    await _createLocalDatabase(db);
    await _createBasicDatabase(db);
    await _createCaloryIntakeDatabase(db);
  }

  _createLocalDatabase(Database db) async {
    await db
        .execute(
          """CREATE TABLE data (
              ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              breakfast INTEGER,
              lunch INTEGER,
              dinner INTEGER,
              calorieintake INTEGER,
              calorieburned INTEGER,
              date TEXT,
              day TEXT,
              timestamp TIMESTAMP 
            )""",
        )
        .then((_) => print('creating table chats...'))
        .catchError((e) => print('error creating chats table: $e'));
  }

  _createBasicDatabase(Database db) async {
    print("done done");
    await db
        .execute("""
          CREATE TABLE basicdata (
	            ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              height INTEGER,
              weight INTEGER,
              age INTEGER,
              activity INTEGER,
              gender TEXT,
              name VARCHAR
            )
      """)
        .then((_) => print('creating table messages'))
        .catchError((e) => print('error creating Messages table: $e'));
  }

  _createCaloryIntakeDatabase(Database db) async {
    await db.execute("""
    CREATE TABLE caloryIntake (
	            ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              amount INTEGER,
              calory INTEGER,
              date TEXT,
              name TEXT,
              meal TEXT
            )
    """);
  }
}
