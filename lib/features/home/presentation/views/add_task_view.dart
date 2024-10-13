import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasky_todo_app/core/di/dependency_injection.dart';
import 'package:tasky_todo_app/features/home/data/repos/add_task_repo_impl.dart';
import 'package:tasky_todo_app/features/home/presentation/view_model/add_task_cubit/add_task_cubit_cubit.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/add_task_view_body.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTaskCubitCubit(getIt.get<AddTaskRepoImpl>()),
      child: const Scaffold(
        body: SafeArea(child: AddTaskViewBody()),
      ),
    );
  }
}
