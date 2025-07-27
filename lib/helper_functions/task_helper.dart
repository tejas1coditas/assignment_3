import 'package:flutter/material.dart';
import 'package:assignment_3/models/task_model.dart';

class TaskHelper {
   void saveTask({
    required BuildContext context,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required TextEditingController dueDateController,
  }) {
    final title = titleController.text.trim();
    final dueDate = dueDateController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty || dueDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'All fields must be filled!!',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
      return;
    }

    final updatedTask = TaskModel(
      title: title,
      description: description,
      dueDate: dueDate,
    );

    Navigator.pop(context, updatedTask);
  }
}
