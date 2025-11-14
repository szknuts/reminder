///タスクを表すモデル
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  ///JSONからTaskを作成
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title']! as String,
      isCompleted: json['isCompleted']! as bool,
    );
  }

  ///TaskをJSONに変換可能なマップに変換
  Map<String, dynamic> toJson() {
    return {'title': title, 'isCompleted': isCompleted};
  }
}
