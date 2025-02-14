import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migrations/sqflite_migrations.dart';

// v1_create_table_produtos.dart
class V1CreateTableProdutos extends Migration {
  V1CreateTableProdutos() : super("V1_CreateTableProdutos");

  @override
  Future<void> execute(Database db) async {
    await db.execute('''
      CREATE TABLE produtos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT
      )
    ''');
  }
}

// v2_add_preco_to_produtos.dart
class V2AddPrecoToProdutos extends Migration {
  V2AddPrecoToProdutos() : super("V2_AddPrecoToProdutos");

  @override
  Future<void> execute(Database db) async {
    await db.execute('ALTER TABLE produtos ADD COLUMN preco REAL DEFAULT 0');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final List<Migration> migrations = [
    V1CreateTableProdutos(),
    V2AddPrecoToProdutos(),
  ];

  final dbInitializer =
      DatabaseInitializer(dbName: "meu_banco.db", migrations: migrations);
  final Database db = await dbInitializer.open();

  print("Banco de dados iniciado!");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Sqflite Migrations")),
        body: const Center(child: Text("Banco configurado com sucesso!")),
      ),
    );
  }
}
