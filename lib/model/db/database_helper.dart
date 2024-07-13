import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:jopi_restaurant/model/listrestaurant.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tableFavorite = 'favorite';

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = await openDatabase(
      join(path, 'restaurant.db'),
      onCreate: (db, version) async {
        try {
          await db.execute('''CREATE TABLE $_tableFavorite(
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            city TEXT,
            pictureId TEXT,
            rating REAL
          )''');
          print('Table $_tableFavorite created successfully');
        } catch (e) {
          print('Error creating table: $e');
        }
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertBookmark(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tableFavorite, restaurant.toJson());
  }

  Future<List<Restaurant>> getBookmarks() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tableFavorite);
    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map<String, dynamic>?> getBookmarkById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<void> removeBookmark(String id) async {
    final db = await database;
    await db!.delete(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
