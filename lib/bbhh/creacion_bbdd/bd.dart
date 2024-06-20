// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DBHelper {
//   static final DBHelper _instance = DBHelper._internal();
//   factory DBHelper() => _instance;
//   DBHelper._internal();

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB();
//     return _database!;
//   }

//   Future<Database> _initDB() async {
//     String path = join(await getDatabasesPath(), 'products.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE products(
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             name TEXT,
//             description TEXT,
//             price INTEGER,
//             stars INTEGER,
//             img TEXT,
//             location TEXT,
//             createdAt TEXT,
//             updatedAt TEXT
//           )
//         ''');
//       },
//     );
//   }

//   Future<void> insertProduct(ProductModel product) async {
//     final db = await database;
//     await db.insert('products', product.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<List<ProductModel>> getProducts() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('products');
//     return List.generate(maps.length, (i) {
//       return ProductModel.fromMap(maps[i]);
//     });
//   }
// }