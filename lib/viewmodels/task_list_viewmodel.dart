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
    } catch (e) {
      _logger.warning('タスク読み込みエラー: $e');
    }
  }

  /// タスク追加
  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) return;
    try {
      final newTask = Task(title: title);
      tasks.add(newTask);
      await _taskRepository.saveTasks(tasks);
      notifyListeners();
    } catch (e) {
      _logger.warning('タスク追加エラー: $e');
    }
  }

  /// タスク削除
  Future<void> removeTask(int index) async {
    tasks.removeAt(index);
    await _taskRepository.saveTasks(tasks);
    notifyListeners();
  }

  /// タスク完了状態切り替え
  Future<void> toggleTaskCompletion(int index) async {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    await _taskRepository.saveTasks(tasks);
    notifyListeners();
  }
}
