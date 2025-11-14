import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reminder/models/task_model.dart';

/// タスクの保存・読み込みを担当するリポジトリクラス
class TaskRepository {
  /// タスク保存用のキー
  static const String _tasksKey = 'tasks_key';

  /// タスクをストレージから読み込む
  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> taskJsonList = prefs.getStringList(_tasksKey) ?? [];

    return taskJsonList.map((taskJson) {
      final Map<String, dynamic> taskMap = jsonDecode(taskJson);
      return Task.fromJson(taskMap);
    }).toList();
  }

  /// タスクをストレージに保存する
  Future<void> saveTasks(List<Task> items) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> taskJsonList = items.map((task) {
      final Map<String, dynamic> taskMap = task.toJson();
      return jsonEncode(taskMap);
    }).toList();

    await prefs.setStringList(_tasksKey, taskJsonList);
  }
}
