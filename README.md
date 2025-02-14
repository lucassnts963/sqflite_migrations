# sqflite_migrations 📦

Gerencie migrations no Sqflite de forma fácil e escalável no Flutter.

## 📌 Recursos

✅ Criação e atualização do banco de dados com versões incrementais
✅ Migrations controladas para evitar duplicação de execução
✅ Evolução segura do banco, permitindo novas colunas e tabelas
✅ Escalável e fácil de manter em projetos Flutter

## 🚀 Instalação

Adicione ao `pubspec.yaml`:

```yaml
dependencies:
  sqflite: ^2.4.1
  sqflite_migrations: ^0.1.0
```

Instale com:

```sh
flutter pub get
```

## 📄 Como Usar?

### 1️⃣ Defina suas migrations

```dart
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

final List<Migration> migrations = [
  V1CreateTableProdutos(),
  V2AddPrecoToProdutos(),
];
```

### 2️⃣ Inicialize o banco de dados

```dart
final dbInitializer = DatabaseInitializer(dbName: "app_database.db", migrations: migrations);
final Database db = await dbInitializer.open();
```

### 3️⃣ Use o banco normalmente

```dart
await db.insert("produtos", {"nome": "Smartphone", "preco": 1999.99});
List<Map<String, dynamic>> produtos = await db.query("produtos");
print(produtos);
```

### ⚡ Benefícios

🔹 Evita recriação de tabelas ao atualizar o app
🔹 Adiciona colunas sem perder dados
🔹 Executa apenas as migrations necessárias

### 🤝 Contribuindo

🔹 Faça um fork do projeto
🔹 Crie uma branch com sua feature: git checkout -b minha-feature
🔹 Commit suas mudanças: git commit -m "Adiciona nova funcionalidade"
🔹 Envie para o repositório: git push origin minha-feature
🔹 Abra um Pull Request

### 📜 Licença

Este projeto está licenciado sob a MIT License - veja o arquivo LICENSE.

### ⭐ Gostou?

Deixe um ⭐ no repositório e contribua para o projeto! 🚀

### 🔗 Links Úteis

[Documentação do Sqflite]()
[Repositório GitHub]()
