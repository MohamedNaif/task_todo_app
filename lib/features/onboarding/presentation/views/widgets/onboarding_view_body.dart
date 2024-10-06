import 'package:flutter/material.dart';

import 'package:tasky_todo_app/core/theming/app_style.dart';
import 'package:tasky_todo_app/features/onboarding/presentation/views/widgets/onboarding_button.dart';

import '../../../../../core/helper/assets.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.55,
            width: MediaQuery.sizeOf(context).width,
            child: Image.asset(AssetsDate.artImage)),
        Text(
          'Task Management & ',
          style: AppStyle.textStyle24(),
        ),
        Text(
          'To-Do List',
          style: AppStyle.textStyle24(),
        ),
        const SizedBox(height: 8),
        Text(
          'This productive tool is designed to help',
          style: AppStyle.textStyle14(),
        ),
        Text(
          'you better manage your task  ',
          style: AppStyle.textStyle14(),
        ),
        Text(
          'project-wise conveniently!',
          style: AppStyle.textStyle14(),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.07),
        const OnboardingButton()
      ],
    );
  }
}
