import 'package:assignment_3/models/task_model.dart';
import 'package:flutter/material.dart';

class EditTask extends StatefulWidget {
  final TaskModel task;
  const EditTask({super.key, required this.task});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController titleController;
  late TextEditingController dueDateController;
  late TextEditingController descriptionController;

  void saveTask() {
    final title = titleController.text.trim();
    final dueDate = dueDateController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty || dueDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'All fields must be filled!!,',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
      return;
    }
    final updatedTask = TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      dueDate: dueDateController.text,
    );
    Navigator.pop(context, updatedTask);
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    dueDateController = TextEditingController(text: widget.task.dueDate);
    descriptionController = TextEditingController(
      text: widget.task.description,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task Name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 10),

            Container(
              height: 56,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 0, 10),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ),

            SizedBox(height: 30),
            Text(
              'Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Container(
              height: 144,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),

              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 0, 10),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(height: 30),

            Text(
              'Due date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Container(
              height: 56,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 0, 10),
                child: TextField(
                  controller: dueDateController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ),

            SizedBox(height: 300),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveTask,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
