import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_todo_app/core/di/dependency_injection.dart';

import 'package:tasky_todo_app/features/profile/data/repos/profile_repo_impl.dart';
import 'package:tasky_todo_app/features/profile/presentation/view_model/cubit/profile_cubit_cubit.dart';
import 'package:tasky_todo_app/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubitCubit(getIt.get<ProfileRepoImpl>()),
      child: const Scaffold(
        body: SafeArea(child: ProfileViewBody()),
      ),
    );
  }
}
