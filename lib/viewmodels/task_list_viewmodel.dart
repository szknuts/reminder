import 'package:flutter/material.dart';
import 'package:reminder/models/task_model.dart';
import 'package:reminder/repositories/task_repository.dart';
import 'package:logging/logging.dart';

class TaskListViewModel extends ChangeNotifier {
  List<Task> tasks = [];
  final Logger _logger = Logger('TaskListViewModel');
  final TaskRepository _taskRepository = TaskRepository();

  /// 初期化時にローカルストレージからタスク読み込み
  Future<void> loadTasks() async {
    try {
      tasks = await _taskRepository.loadTasks();
      notifyListeners();
    } catch (e) {
      _logger.warning('タスク読み込みエラー: $e');
    }
  }

  /// タスク追加
  Future<void> addTask(String title) async {
    final t = title.trim();
    if (t.isEmpty) return;
    try {
      final newTask = Task(title: t);
      tasks.add(newTask);
      await _taskRepository.saveTasks(tasks);
      notifyListeners();
    } catch (e) {
      _logger.warning('タスク追加エラー: $e');
    }
  }

  /// タスク削除
  Future<void> removeTask(int index) async {
    if (index < 0 || index >= tasks.length) return;
    try {
      tasks.removeAt(index);
      await _taskRepository.saveTasks(tasks);
      notifyListeners();
    } catch (e) {
      _logger.warning('タスク削除エラー: $e');
    }
  }

  /// タスク完了状態切り替え
  Future<void> toggleTaskCompletion(int index) async {
    if (index < 0 || index >= tasks.length) return;
    try {
      tasks[index].isCompleted = !tasks[index].isCompleted;
      await _taskRepository.saveTasks(tasks);
      notifyListeners();
    } catch (e) {
      _logger.warning('タスク完了切り替えエラー: $e');
    }
  }
}
