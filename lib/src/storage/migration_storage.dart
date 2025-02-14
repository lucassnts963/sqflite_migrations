import 'package:sqflite/sqflite.dart';

class MigrationStorage {
  static Future<void> createMigrationTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS migrations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  static Future<List<String>> getAppliedMigrations(Database db) async {
    final List<Map<String, dynamic>> results = await db.query('migrations');
    return results.map((m) => m['nome'] as String).toList();
  }

  static Future<void> saveMigration(Database db, String name) async {
    await db.insert('migrations', {"name": name});
  }
}
