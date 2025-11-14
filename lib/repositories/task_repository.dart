import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reminder/models/task_model.dart';
import 'package:logging/logging.dart';

/// タスクの保存・読み込みを担当するリポジトリクラス
class TaskRepository {
  /// タスク保存用のキー
  static const String _tasksKey = 'tasks_key';
  final Logger _logger = Logger('TaskRepository');

  /// タスクをストレージから読み込む
  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> taskJsonList = prefs.getStringList(_tasksKey) ?? [];
    final List<Task> result = [];
    //JSON -> Map
    for (final taskJson in taskJsonList) {
      try {
        final Map<String, dynamic> taskMap = jsonDecode(taskJson);
        result.add(Task.fromJson(taskMap));
      } catch (e) {
        _logger.warning(e);
      }
    }

    return result;
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
