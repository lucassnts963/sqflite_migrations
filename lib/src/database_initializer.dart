import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migrations_pro/src/models/migration.dart';

class DatabaseInitializer {
  final String dbName;
  final List<Migration> migrations;

  DatabaseInitializer({required this.dbName, required this.migrations});

  Future<Database> open() async {
    return await openDatabase(
      dbName,
      version: migrations.length,
      onCreate: (db, version) async {
        for (var migration in migrations) {
          await migration.execute(db);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (int i = oldVersion; i < newVersion; i++) {
          await migrations[i].execute(db);
        }
      },
    );
  }
}
