import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class DBProvider {
  static final DBProvider db = DBProvider();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Database? getDB() {
    return _database;
  }

  initDB() async {
    String path;
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      path = "/assets/db";
    } else {
      Directory documentsDirectory = await getApplicationSupportDirectory();
      path = join(documentsDirectory.path, "MusicDB.db");
    }

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      db.execute("""
            CREATE TABLE music (
              id integer PRIMARY KEY AUTOINCREMENT,
              singer text NOT NULL,
              name text NOT NULL,
              time_ datetime
            );
          """);
    });
  }
}
