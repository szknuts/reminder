import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/viewmodels/task_list_viewmodel.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  // final TaskRepository _repository = TaskRepository();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("新しいタスク"),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: "タスクを入力"),
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
                final text = _textController.text.trim();
                if (text.isNotEmpty) {
                  context.read<TaskListViewModel>().addTask(text);
                  _textController.clear();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ReminderTodo')),

      body: Consumer<TaskListViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.tasks.length,
            itemBuilder: (context, index) {
              final task = viewModel.tasks[index];
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
                  viewModel.toggleTaskCompletion(index);
                },
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        tooltip: "Add Reminder",
        child: const Icon(Icons.add),
      ),
    );
  }
}
