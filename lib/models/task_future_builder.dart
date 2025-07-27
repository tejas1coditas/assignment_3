import 'package:assignment_3/models/task_model.dart';

class TaskDatabase {
  static  List<TaskModel> tasklist = [];

  Future<List<TaskModel>> getTask() async {
    await Future.delayed(Duration(seconds: 1));

    return tasklist;
  }

  static void updateTask(TaskModel oldTask, TaskModel newTask) {
    final index = tasklist.indexOf(oldTask);
    tasklist[index] = newTask;
  }

  static void addTask(TaskModel task) {
    tasklist.add(task);
  }
}
