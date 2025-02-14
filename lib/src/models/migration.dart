import 'package:sqflite/sqflite.dart';

abstract class Migration {
  final String name;
  Migration(this.name);
  Future<void> execute(Database db);
}
