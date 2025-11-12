import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final List<String> dummyItems = const [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder',

      home: Scaffold(
        appBar: AppBar(
          title: const Text('リマインダー'),
          backgroundColor: Colors.red,
        ),

        body: ListView.builder(
          itemCount: dummyItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.circle_outlined),
              title: Text(dummyItems[index]),
            );
          },
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //
          },
          backgroundColor: Colors.red,
          tooltip: "Add Reminder",
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
