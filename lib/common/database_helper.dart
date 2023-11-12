import 'package:sqflite/sqflite.dart';

import 'constants.dart';

class DatabaseHelper {
  /// helper class for local DB using Sqflite package
  static late Database database;

  static init() async {
    /// create or open existing local database
    database = await openDatabase(
      localDbName,
      version: 1,
      onCreate: (database, version) {
        /// on creating new database, create wallpaper table
        database
            .execute(
                'CREATE TABLE wallpapers (id INTEGER PRIMARY KEY, original TEXT, large2x TEXT, medium TEXT)')
            .catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
    );
  }

  static Future<List<Map<String, Object?>>> fetchTableRecords({
    required String table,
  }) async {
    return await database.query(table);
  }

  static insertIntoDatabase({
    required String table,
    required dynamic object,
  }) async {
    /// insert database record
    await database.transaction((txn) async {
      await txn.insert(table, object.toMap()).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  static removeFromDatabase({
    required String table,
    required dynamic object,
  }) async {
    /// remove database record by id
    await database.transaction((txn) async {
      await txn
          .delete(table, where: 'id == ${object.id}')
          .catchError((error) {
        print('Error When Deleting Record ${error.toString()}');
      });
    });
  }
}
