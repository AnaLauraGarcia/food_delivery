import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:food_delivery/models/sign_up_body_model.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();
  static Database? _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE user (
        id $idType,
        name $textType,
        phone $textType,
        email $textType,
        password $textType
      )
    ''');
  }
  
  Future<void> createUser(SignUpBody user) async {
    final db = await database;
    await db.insert('user', user.toMap());
  }

  Future<List<SignUpBody>> readAllUsers() async {
    final db = await database;
    final result = await db.query('user');
    return result.map((map) => SignUpBody.fromMap(map)).toList();
  }

  Future<int> updateUser(SignUpBody user) async {
    final db = await database;
    return db.update(
      'user',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return db.delete(
      'user',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> loginUser(String email, String password) async {
    final db = await database;
    var result = await db.query(
      'user',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty;
  }

  Future<void> showDatabaseContents() async {
    final db = await database;

    // Consultar todos los usuarios
    List<Map<String, dynamic>> users = await db.query('user');

    // Imprimir los resultados en la consola
    users.forEach((user) {
      print(user);
    });
  }
}
