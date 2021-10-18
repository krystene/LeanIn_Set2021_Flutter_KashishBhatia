import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'To-do'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _todos = <Task>[
    Task(
        description: 'Submit the flutter project.',
        completed: false),
    Task(description: 'competitive programming', completed: false),
    Task(
        description:
            'Practicing yoga ',
        completed: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _todos.clear();
              });
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: ListView(
        children: _todos
            .map((e) => CheckboxListTile(
                  value: e.completed,
                  title: Text(e.description),
                  onChanged: (val) {
                    setState(() {
                      e.completed = !e.completed; // toggle the completion
                    });
                  },
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<Task>(
            context: context,
            builder: (context) {
              final _textController = TextEditingController();

              return AlertDialog(
                title: Text('Add a new task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Add a new task"),
                    TextField(
                      controller: _textController,
                      decoration:
                          InputDecoration(labelText: 'New Task Description'),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            Task(
                                description: _textController.text,
                                completed: false),
                          );
                        },
                        icon: Icon(Icons.add),
                        label: Text("Add Task"))
                  ],
                ),
              );
            },
          ).then((value) {
            setState(() {
              if (value != null) {
                _todos.add(value);
              }
            });
          });
        },
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Task {
  String description;
  bool completed;

  Task({
    required this.description,
    required this.completed,
  });
}