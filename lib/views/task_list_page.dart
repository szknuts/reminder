import 'package:flutter/material.dart';
import "package:reminder/repositories/task_repository.dart";
import 'package:reminder/models/task_model.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});
  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  // 5. (新設) Repository のインスタンス（実体）を作成
  final TaskRepository _repository = TaskRepository();

  List<Task> items = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final loadedTasks = await _repository.loadTasks();
    setState(() {
      items = loadedTasks;
    });
  }

  Future<void> _saveTasks() async {
    await _repository.saveTasks(items);
  }

  void _toggleTask(int index) {
    setState(() {
      items[index].isCompleted = !items[index].isCompleted;
      _saveTasks();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ReminderTodo')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final task = items[index];

          return ListTile(
            leading: Icon(
              task.isCompleted ? Icons.check_circle : Icons.circle_outlined,
            ),
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
                color: task.isCompleted ? Colors.grey : null,
              ),
            ),
            onTap: () {
              _toggleTask(index);
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("add new reminder"),
                content: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: "Enter reminder here",
                  ),
                  autofocus: true,
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("キャンセル"),
                    onPressed: () {
                      _textController.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text("追加"),
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        setState(() {
                          items.add(Task(title: _textController.text));
                          _saveTasks();
                          _textController.clear();
                        });
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: "Add Reminder",
        child: const Icon(Icons.add),
      ),
    );
  }
}
