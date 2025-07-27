import 'package:assignment_3/helper_functions/task_helper.dart';

import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final helper = TaskHelper();

  @override
  Widget build(BuildContext context) {
    double d1 = MediaQuery.of(context).size.height;
    double d2 = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('New Task'), centerTitle: true),

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
                height: d1*0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 5, 0, 10),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(fontSize: 17),
                      border: InputBorder.none,
                    ),
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
                height: d1*0.18,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
        
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 5, 0, 10),
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(fontSize: 17),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
        
                 SizedBox(height: d1 * 0.030),
            Text(
              'Due Date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: d1 * 0.013),
        
              Container(
                height: d1*0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
        
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 5, 0, 10),
                  child: TextField(
                    controller: dueDateController,
                    decoration: InputDecoration(
                      hintText: 'Due Date',
                      hintStyle: TextStyle(fontSize: 17),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
        
              SizedBox(height: d1*0.27),
              SizedBox(
                height: d1*0.055,
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
