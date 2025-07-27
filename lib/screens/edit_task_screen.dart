import 'package:assignment_3/helper_functions/task_helper.dart';
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
  final helper = TaskHelper();

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
    double d1 = MediaQuery.of(context).size.height;
    double d2 = MediaQuery.of(context).size.width;
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

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(d2*0.04,d2*0.04,d2*0.04,d2*0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
        
              SizedBox(height: d1 * 0.013),
        
              Container(
                height: d1 * 0.07,
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
        
              SizedBox(height: d1 * 0.030),
              Text(
                'Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: d1 * 0.013),
              Container(
                height: d1 * 0.17,
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
              SizedBox(height: d1 * 0.030),
        
              Text(
                'Due date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: d1 * 0.013),
              Container(
                height: d1 * 0.07,
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
        
              SizedBox(height: d1 * 0.27),
              SizedBox(
                height: d1 * 0.055,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    helper.saveTask(
                      context: context,
                      titleController: titleController,
                      descriptionController: descriptionController,
                      dueDateController: dueDateController,
                    );
                  },
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
      ),
    );
  }
}
