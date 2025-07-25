import 'package:assignment_3/models/task_database.dart';
import 'package:assignment_3/models/task_model.dart';
import 'package:assignment_3/screens/add_task_screen.dart';
import 'package:assignment_3/screens/edit_task_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<TaskModel>> taskfuture = TaskDatabase().getTask();

  // void initstate() {
  //   super.initState();

  //   taskfuture = TaskDatabase().getTask();
  // }

  void refreshTask() {
    setState(() {
      taskfuture = TaskDatabase().getTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Tasks  ${TaskDatabase.tasklist.length}'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final newTask = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddTaskScreen()),
              );
              if (newTask != null && newTask is TaskModel) {
                TaskDatabase.addTask(newTask);
                refreshTask();
              }
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),

      body: FutureBuilder<List<TaskModel>>(
        future: taskfuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final tasks = snapshot.data!;

          return ListView.builder(
            itemCount: tasks.length,

            itemBuilder: (_, index) {
              var task = tasks[index];
              return ListTile(
                onTap: () async {
                  final updatedTask = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditTask(task: task)),
                  );
                  if (updatedTask != null) {
                    TaskDatabase.updateTask(task, updatedTask);
                    setState(() {
                      task = updatedTask;
                    });
                  }
                },
                leading: Container(
                  height: 48,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.menu),
                ),

                title: Text(task.title),
                subtitle: Text(task.dueDate),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTaskScreen()),
          );
          if (newTask != null && newTask is TaskModel) {
            TaskDatabase.addTask(newTask);
            refreshTask();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
