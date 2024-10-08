import 'package:flutter/material.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/add_task_view_body.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: AddTaskViewBody()),
    );
  }
}