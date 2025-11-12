import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),

      home: const ReminderHomePage(),
    );
  }
}

class ReminderHomePage extends StatefulWidget {
  const ReminderHomePage({super.key});
  @override
  State<ReminderHomePage> createState() => _ReminderHomePageState();
}

class _ReminderHomePageState extends State<ReminderHomePage> {
  List<String> items = ['dummy Item 1', 'dummy Item 2', 'dummy Item 3'];

  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('リマインダー')),

      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.circle_outlined),
            title: Text(items[index]),
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
                          items.add(_textController.text);
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
