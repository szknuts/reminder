import 'package:shared_preferences/shared_preferences.dart';

/// タスクの保存・読み込みを担当するリポジトリクラス
class TaskRepository {
  /// タスク保存用のキー
  static const String _tasksKey = 'tasks_key';

  /// タスクを読み込む
  Future<List<String>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_tasksKey) ?? [];
  }

  /// タスクを保存する
  Future<void> saveTasks(List<String> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_tasksKey, items);
  }
}
