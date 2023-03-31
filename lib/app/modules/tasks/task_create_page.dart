import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';

class TaskCreatePage extends StatelessWidget {
  final TaskCreateController _controller;

  const TaskCreatePage({super.key, required TaskCreateController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
