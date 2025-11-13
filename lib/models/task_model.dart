import 'dart:convert';

/// タスククラス
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'isCompleted': isCompleted};
  }
}
