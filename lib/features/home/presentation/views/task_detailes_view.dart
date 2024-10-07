import 'package:flutter/material.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/task_detailes_view_body.dart';

class TaskDetailesView extends StatelessWidget {
  const TaskDetailesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: TaskDetailesViewBody()),
    );
  }
}