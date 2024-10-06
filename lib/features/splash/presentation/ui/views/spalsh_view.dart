import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/features/splash/presentation/ui/views/widgets/splash_view_body.dart';

class SpalshView extends StatelessWidget {
  const SpalshView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:primaryColor,
      body:SplashViewBody()
    );
  }
}