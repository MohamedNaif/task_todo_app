import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_todo_app/core/di/dependency_injection.dart';
import 'package:tasky_todo_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:tasky_todo_app/features/auth/presentation/view_model/auth_cubit/auth_cubit_cubit.dart';
import 'package:tasky_todo_app/features/auth/presentation/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubitCubit(getIt.get<AuthRepoImpl>()),
      child: const Scaffold(
        resizeToAvoidBottomInset: true,
        body: LoginViewBody(),
      ),
    );
  }
}
