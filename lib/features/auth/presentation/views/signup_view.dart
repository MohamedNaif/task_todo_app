import 'package:flutter/material.dart';
import 'package:tasky_todo_app/features/auth/presentation/views/widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: SignupViewBody(),
    );
  }
}
