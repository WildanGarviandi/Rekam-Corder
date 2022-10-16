import 'dart:ffi';
import 'dart:io';

import 'package:rekam_corder/data/recorded.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';

class Storage {
  Storage._();
  static final instance = Storage._();

  late Database _db;

  void openDB() {
    print('setting up db');
    open.overrideFor(OperatingSystem.linux, _openOnLinux);
    print('Using sqlite3 version : ${sqlite3.version}');

    _db = sqlite3.open('rekamcorder');
    _createTable(_db);
  }

  void closeDB() {
    _db.dispose();
  }

  Future<List<Recorded>?> getAllListRecord() async {
    try {
      final ResultSet resultSet = _db.select('SELECT * FROM recorded');
      List<Recorded> listRecorded = [];
      for (final Row row in resultSet) {
        Recorded temp = Recorded(
            recordId: row['id'],
            title: row['title'],
            date: row['date'],
            length: row['length']);
        listRecorded.add(temp);
      }
      print('${listRecorded.last.date} sdf : ${listRecorded.last.title}');
      return listRecorded;
    } catch (err) {
      print('Failed to get list of record : $err');
      return null;
    }
  }

  void saveRecord(Recorded record) {
    final stmt = _db
        .prepare('INSERT INTO recorded (title, date, length) VALUES (?, ?, ?)');
    stmt.execute([record.title, record.date, record.length]);
    print('Start saving : ${record.title}');
    stmt.dispose();
  }

  void removeRecorded(int recordId) {
    final stmt = _db.prepare('');
  }

  void removeAllrecorded() {
    final stmt = _db.prepare('DELETE * FROM recorded');
  }

  DynamicLibrary _openOnLinux() {
    final scriptDir = File(Platform.script.toFilePath()).parent;
    final libraryNextToScript =
        File('${scriptDir.path}/linux/library/libsqlite3.so');
    print(libraryNextToScript.path);
    return DynamicLibrary.open(libraryNextToScript.path);
  }

  void _createTable(Database db) {
    db.execute('''
      CREATE TABLE IF NOT EXISTS recorded (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        date TEXT NOT NULL,
        length TEXT NOT NULL
      );
    ''');
    print('DB Created');
  }
}
