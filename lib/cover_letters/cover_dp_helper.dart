import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cover_letters.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE cover_letters(
            id INTEGER PRIMARY KEY,
            title TEXT,
            yourName TEXT,
            yourAddress TEXT,
            yourCity TEXT,
            yourEmail TEXT,
            yourPhone TEXT,
            employerName TEXT,
            employerTitle TEXT,
            companyName TEXT,
            companyAddress TEXT,
            companyCity TEXT,
            content TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> insertCoverLetter(Map<String, dynamic> coverLetter) async {
    final db = await database;
    await db.insert(
      'cover_letters',
      coverLetter,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getCoverLetters() async {
    final db = await database;
    return await db.query('cover_letters');
  }

  Future<Map<String, dynamic>?> getCoverLetter(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result =
    await db.query('cover_letters', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> deleteCoverLetter(int id) async {
    final db = await database;
    await db.delete('cover_letters', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateCoverLetterField(int id, String field, String value) async {
    final db = await database;
    await db.update(
      'cover_letters',
      {field: value},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
