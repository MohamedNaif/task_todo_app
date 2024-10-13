import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_todo_app/core/di/dependency_injection.dart';
import 'package:tasky_todo_app/features/home/data/models/task_model/task_model.dart';
import 'package:tasky_todo_app/features/home/data/repos/task_detailes_repo_impl.dart';
import 'package:tasky_todo_app/features/home/presentation/view_model/task_detailes/task_detailes_cubit.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/task_detailes_view_body.dart';

class TaskDetailesView extends StatelessWidget {
  const TaskDetailesView({super.key});

  @override
  Widget build(BuildContext context) {
    final taskId = ModalRoute.of(context)!.settings.arguments;

    //  final TaskModel task = ModalRoute.of(context)!.settings.arguments as TaskModel;
    return BlocProvider(
      create: (context) => TaskDetailesCubit(getIt.get<TaskDetailsRepoImpl>()),
      child: Scaffold(
        body: SafeArea(
            child: TaskDetailesViewBody(
          taskId: taskId.toString(),
        )),
      ),
    );
  }
}
