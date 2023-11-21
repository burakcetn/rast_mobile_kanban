import 'package:path/path.dart';
import 'package:rast_mobile_kanban/data/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepository {
  static final DatabaseRepository instance = DatabaseRepository._instance();
  static Database? _db;

  DatabaseRepository._instance();

  Future<Database> get db async {
    _db ??= await _initDb();

    return _db!;
  }

  Future<Database> _initDb() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'task_database.db');

    final taskDb = await openDatabase(path, version: 1, onCreate: _createDb);

    return taskDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT,date TEXT,status TEXT,assignee TEXT)');
  }

  Future<void> insertTask(TaskModel task) async {
    await _db?.insert(
      "tasks",
      task.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TaskModel>> getTasks() async {
    final List<Map<String, dynamic>> maps = await _db!.query('tasks');

    return List.generate(maps.length, (i) {
      return TaskModel(
        id: maps[i]['id'] as int,
        title: maps[i]['title'] as String,
        description: maps[i]['description'] as String,
        date: maps[i]['date'] as String,
        status: maps[i]['status'] as String,
        assignee: maps[i]['assignee'] as String,
      );
    });
  }

  Future<void> updateStatus(int taskId, String newStatus) async {
    await _db!.update(
      'tasks',
      {'status': newStatus},
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  Future<void> deleteTask(int id) async {
    await _db!.delete(
      "tasks",
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
