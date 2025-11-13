import 'package:flutter_vai_ou_racha/model/cliente.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE clientes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        idade INTEGER NOT NULL,
        email TEXT NOT NULL,
        telefone TEXT NOT NULL,
        endereco TEXT NOT NULL,
        cpf TEXT NOT NULL,
        peso REAL NOT NULL
      )
    ''');
  }

  Future<Cliente> create(Cliente cliente) async {
    final db = await database;
    final id = await db.insert('clientes', cliente.toJson());
    return cliente.copyWith(id: id);
  }

  Future<Cliente?> readCliente(int id) async {
    final db = await database;

    final maps = await db.query(
      'clientes',
      columns: [
        'id',
        'nome',
        'idade',
        'email',
        'telefone',
        'endereco',
        'cpf',
        'peso',
      ],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Cliente.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Cliente>> readAllClientes() async {
    final db = await database;
    final result = await db.query('clientes');
    return result.map((json) => Cliente.fromJson(json)).toList();
  }

  Future<int> update(Cliente cliente) async {
    final db = await database;
    return db.update(
      'clientes',
      cliente.toJson(),
      where: 'id = ?',
      whereArgs: [cliente.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete('clientes', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await database;
    db.close();
  }

  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');
    await deleteDatabase(path);
    _database = null;
    print('Database reset completed.');
  }
}
