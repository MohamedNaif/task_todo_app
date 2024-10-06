import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {


   @override
     void initState() {
    super.initState();
    navigateToHome();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(seconds: 4),
      () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, onboardingView);
        }
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.5,
        width: MediaQuery.sizeOf(context).width * 0.5,
        child: const Image(
          image: AssetImage(AssetsDate.logo),
        ),
      ),
    );
  }
}
