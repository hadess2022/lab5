import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart';

class DBProvider
{
  DBProvider._();

  static DBProvider db = DBProvider._();

  static Database? _database;

  // Правильный getter с гарантированной инициализацией
  Future<Database> database() async {
    if (_database != null) return _database!;
    final dbPath = await sql.getDatabasesPath();
    final pathToDb = path.join(dbPath, 'calculations.db');
    
    _database = await sql.openDatabase(
      pathToDb,
      version: 1,
      onCreate: _createDB
    );

    return _database!;
  }

  Future<void> _createDB(Database db, int version) async
  {
    await db.execute("""CREATE TABLE math(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    long INTEGER NOT NULL,
    discretisation INTEGER NOT NULL,
    dip INTEGER NOT NULL,
    sterio boolean NOT NULL,
    rezalt NOT NULL
    )""");
  }

  Future<void> setToBD(int long, int discretisation, int dip, bool sterio, int rezalt) async 
  {
    final db = await database();
    db.execute("INSERT INTO math(long, discretisation, dip, sterio, rezalt) VALUES (?, ?, ?, ?, ?)", [long, discretisation, dip, sterio ? 1 : 0, rezalt]);
  }

  Future<List<Map<String, dynamic>>> getFromBD(String query, String filter) async 
  {
    final db = await database();
    return await db.rawQuery("SELECT $query FROM math $filter");
  }

  Future<void> deleteFromBD(String filter) async 
  {
    final db = await database();
    db.rawDelete("DELETE FROM math $filter");
  }
}