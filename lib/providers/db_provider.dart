import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
export 'package:qr_reader/models/scan_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initDB();
      return _database;
    }
    return _database;
  }

  Future<Database> initDB() async {
    //Path where i will save the database
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "ScansDB.db");
    print(path);
    //Creating the database
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Scans(id INTEGER PRIMARY KEY, type TEXT, value TEXT)');
    });
  }

  //Insertion of the scan
  Future<int> newScanRaw(ScanModel scan) async {
    final type = scan.type;
    final value = scan.value;
    //Check if the database is created

    final db = await database;
    final res = await db!.rawInsert('''
      INSERT INTO Scans (type, value) VALUES ('$type', '$value')
''');
    return res;
  }

  Future<int> newScan(ScanModel scan) async {
    final db = await database;
    final res = await db!.insert('Scans', scan.toJson());
    return res;
  }

  Future<ScanModel?> getScanById(int i) async {
    final db = await database;
    final res = await db!.query('Scans', where: 'id = ?', whereArgs: [i]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db!.query('Scans');
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final res = await db!.rawQuery('SELECT * FROM Scans WHERE type = "$type"');
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<int> updateScan(ScanModel scan) async {
    final db = await database;
    final res = await db!
        .update('Scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);
    return res;
  }

  Future<int> deleteScanById(int id) async {
    final db = await database;
    final res = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  deleteAllScans() async {
    final db = await database;
    final res = await db!.rawDelete('DELETE FROM Scans');
    return res;
  }
}
