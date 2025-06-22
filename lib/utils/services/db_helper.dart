import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._internal();

  DBHelper._internal();

  Database? _db;
  String? currentUserTable;


  Future<void> initDB(String phoneNumber) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'vehicle_rental.db');

    String tableName = 'user_$phoneNumber';
    currentUserTable = tableName;


    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT,
        value TEXT
      )
    ''');
      },
    );

    await _db!.execute('''
  CREATE TABLE IF NOT EXISTS $tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    key TEXT,
    value TEXT
  )
''');
  }

  Future<void> saveData(String key, String value) async {
    if (_db == null || currentUserTable == null) return;
    await _db!.insert(
      currentUserTable!,
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, String>> loadAllData() async {
    final db = _db!;
    if (currentUserTable == null) return {};

    try {
      final List<Map<String, dynamic>> result = await db.query(currentUserTable!);
      return {
        for (var row in result)
          row['key'] as String: row['value'] as String,
      };
    } catch (e) {
      debugPrint("DB ERROR: $e");
      return {}; // Fallback to empty map
    }
  }

}
