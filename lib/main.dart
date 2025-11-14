import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/viewmodels/task_list_viewmodel.dart';
import "package:reminder/views/task_list_page.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReminderTodo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),

      /* めも
      ChangeNotifierProviderはviewmodelの形を提供する
      createでインスタンス作成
      childと子孫はcreateのインスタンスにアクセスできる
      context.read<TaskListViewModel>().tasks ← 値を読む
      context.watch<TaskListViewModel>().tasks ← 値を監視(変更時に再構築)
      viewModelでnotifyListeners()を呼び出すとウィジェットが再構築できる
      */
      home: ChangeNotifierProvider(
        create: (_) => TaskListViewModel(),
        child: const TaskListPage(),
      ),
    );
  }
}
