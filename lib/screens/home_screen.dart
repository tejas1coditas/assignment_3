import 'package:assignment_3/helper_functions/task_helper.dart';
import 'package:assignment_3/models/task_future_builder.dart';
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

  void refreshTask() {
    setState(() {
      taskfuture = TaskDatabase().getTask();
    });
  }

  final helper = TaskHelper();

  @override
  Widget build(BuildContext context) {
    double d1 = MediaQuery.of(context).size.height;
    double d2 = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: StreamBuilder<int>(
          stream: helper.getTaskCount(),
          builder: (context, snapshot) {
            final countofTasks = snapshot.data ?? 0;
            return Text('Tasks ($countofTasks)');
          },
        ),
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
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks available.'));
          }
          final tasks = snapshot.data!;

          return ReorderableListView.builder(
            itemCount: tasks.length,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex -= 1;
                final item = tasks.removeAt(oldIndex);
                tasks.insert(newIndex, item);
                TaskDatabase.tasklist = tasks;
              });
            },
            itemBuilder: (_, index) {
              final task = tasks[index];

              return ListTile(
                key: ValueKey(task),
                onTap: () async {
                  final updatedTask = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditTask(task: task)),
                  );
                  if (updatedTask != null) {
                    TaskDatabase.updateTask(task, updatedTask);
                    refreshTask();
                  }
                },
                leading: ReorderableDragStartListener(
                  index: index,
                  child: Container(
                    height: d1*0.05,
                    width: d2*0.1,
                    decoration: BoxDecoration(
                      
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(7)
                      
                    ),
                    child: Icon(Icons.list)),
                ),
                title: Text(task.title),
                subtitle: Text('Due ${task.dueDate}'),
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
