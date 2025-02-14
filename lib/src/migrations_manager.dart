import 'package:sqflite/sqflite.dart';
import 'models/migration.dart';
import 'storage/migration_storage.dart';

class MigrationsManager {
  final List<Migration> migrations;

  MigrationsManager({required this.migrations});

  Future<void> applyMigrations(Database db) async {
    await MigrationStorage.createMigrationTable(db);

    final appliedMigrations = await MigrationStorage.getAppliedMigrations(db);

    for (var migration in migrations) {
      if (!appliedMigrations.contains(migration.name)) {
        await migration.execute(db);
        await MigrationStorage.saveMigration(db, migration.name);
      }
    }
  }
}
