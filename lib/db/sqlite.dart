import 'package:sqflite/sqflite.dart';
import 'package:storeappver3/models/note.dart';

class SQLiteDatabase {
  static final SQLiteDatabase instance = SQLiteDatabase._init();
  static Database? _database;
  SQLiteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  join(String dbPath, String filePath) {
    return dbPath + filePath;
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    await db.execute('''
  CREATE TABLE $tableNotes (
    ${NoteFields.id} $idType,
    ${NoteFields.isImportant}  $boolType,
    ${NoteFields.number}  $integerType,
    ${NoteFields.title}  $textType,
    ${NoteFields.description}  $textType,
    ${NoteFields.time}  $textType,

  )
''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  // Future<Note> create(Note note) async {

  // }
}
