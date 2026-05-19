import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final DatabaseHelper instance =
      DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {

    if (_database != null) return _database!;

    _database = await _initDB('taskeasy.db');

    return _database!;
  }

  Future<Database> _initDB(
  String filePath,
) async {

  final dbPath =
      await getDatabasesPath();

  final path =
      join(dbPath, filePath);

  await deleteDatabase(path);

  return await openDatabase(

    path,

    version: 1,

    onCreate: _createDB,
  );
}

  Future _createDB(Database db, int version) async {

    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        email TEXT UNIQUE,
        senha TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE tarefas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        descricao TEXT,
        categoria TEXT
      )
    ''');
  }

  Future<int> criarUsuario(
    Map<String, dynamic> usuario,
  ) async {

    final db = await instance.database;

    return await db.insert(
      'usuarios',
      usuario,
    );
  }

  Future<List<Map<String, dynamic>>>
      buscarUsuarios() async {

    final db = await instance.database;

    return await db.query('usuarios');
  }

  Future<Map<String, dynamic>?> login(
    String email,
    String senha,
  ) async {

    final db = await instance.database;

    final result = await db.query(

      'usuarios',

      where: 'email = ? AND senha = ?',

      whereArgs: [email, senha],
    );

    if (result.isNotEmpty) {

      return result.first;
    }

    return null;
  }

  Future<int> criarTarefa(
    Map<String, dynamic> tarefa,
  ) async {

    final db = await instance.database;

    return await db.insert(
      'tarefas',
      tarefa,
    );
  }

  Future<List<Map<String, dynamic>>>
      buscarTarefas() async {

    final db = await instance.database;

    return await db.query('tarefas');
  }

  Future<int> deletarTarefa(
    int id,
  ) async {

    final db = await instance.database;

    return await db.delete(

      'tarefas',

      where: 'id = ?',

      whereArgs: [id],
    );
  }

  Future<int> atualizarTarefa(
    Map<String, dynamic> tarefa,
  ) async {

    final db = await instance.database;

    return await db.update(

      'tarefas',

      tarefa,

      where: 'id = ?',

      whereArgs: [tarefa['id']],
    );
  }
}