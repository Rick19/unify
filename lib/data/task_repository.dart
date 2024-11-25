//  Repositorio de ayuda para acceder a DB 
import 'database_helper.dart';

class TaskRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Map<String, dynamic>>> getTasks({required bool completed}) async {
    final db = await _dbHelper.database;
    return db.query(
      'tasks',
      where: 'completed = ?',
      whereArgs: [completed ? 1 : 0],
    );
  }

  Future<void> addTask(String title, String description) async {
    final db = await _dbHelper.database;
    await db.insert('tasks', {'title': title, 'description':description, 'completed': 0});
  }

  //  Esta función actualiza únicamente el estado más no el contenido
  Future<void> updateTaskStatus(int id, bool completed) async {
    final db = await _dbHelper.database;
    await db.update(
      'tasks',
      {'completed': completed ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await _dbHelper.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
