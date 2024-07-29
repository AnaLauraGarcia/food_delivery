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
    return await openDatabase(path, version: 2, onCreate: _createDB, onUpgrade: _upgradeDB);
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
        password $textType,
        role $textType
      )
    ''');

    // Crear administradores si no existen
    final List<Map<String, dynamic>> result = await db.query('user', where: 'role = ?', whereArgs: ['admin']);
    
    if (result.isEmpty) {
      await db.insert('user', {
        'name': 'Admin1',
        'phone': '1234567890',
        'email': 'admin1@gmail.com',
        'password': 'admin123',
        'role': 'admin',
      });
      
      await db.insert('user', {
        'name': 'Admin2',
        'phone': '0987654321',
        'email': 'admin2@gmail.com',
        'password': 'admin123',
        'role': 'admin',
      });
    }

    // Insertar 5 usuarios simples de cliente con nombres únicos y correos electrónicos
    await db.insert('user', {
      'name': 'Maria',
      'phone': '1234567801',
      'email': 'maria@gmail.com',
      'password': '0606456',
      'role': 'client',
    });

    await db.insert('user', {
      'name': 'Federico',
      'phone': '1234567802',
      'email': 'federico@gmail.com',
      'password': '0606456',
      'role': 'client',
    });

    await db.insert('user', {
      'name': 'Rosa',
      'phone': '1234567803',
      'email': 'rosa@gmail.com',
      'password': '0606456',
      'role': 'client',
    });

    await db.insert('user', {
      'name': 'Pablo',
      'phone': '1234567804',
      'email': 'pablo@gmail.com',
      'password': '0606456',
      'role': 'client',
    });

    await db.insert('user', {
      'name': 'Eva',
      'phone': '1234567805',
      'email': 'eva@gmail.com',
      'password': '0606456',
      'role': 'client',
    });
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE user ADD COLUMN role TEXT NOT NULL DEFAULT "client"');
    }
  }
  
  Future<void> createUser(SignUpBody user) async {
    final db = await database;
    await db.insert('user', user.toMap());
  }

  Future<SignUpBody?> readUser(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'user',
      columns: ['id', 'name', 'phone', 'email', 'password', 'role'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return SignUpBody.fromMap(maps.first);
    } else {
      return null;
    }
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

  Future<int?> loginUser(String email, String password) async {
    final db = await database;
    final result = await db.query('user', where: 'email = ? AND password = ?', whereArgs: [email, password]);

    if (result.isNotEmpty) {
      return result.first['id'] as int;  
    } else {
      return null;
    }
  }

  Future<List<SignUpBody>> getAllUsers() async {
    final db = await database;
    final result = await db.query(
      'user',
      where: 'role = ?',
      whereArgs: ['client'],
    );
    
    return result.map((map) => SignUpBody.fromMap(map)).toList();
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

  Future<SignUpBody?> getUserById(int id) async {
  final db = await database;
  final maps = await db.query(
    'user',
    columns: ['id', 'name', 'phone', 'email', 'password', 'role'],
    where: 'id = ?',
    whereArgs: [id],
  );

  if (maps.isNotEmpty) {
    return SignUpBody.fromMap(maps.first);
  } else {
    return null;
  }
}
}
