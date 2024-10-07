import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/features/auth/presentation/views/login_view.dart';
import 'package:tasky_todo_app/features/auth/presentation/views/signup_view.dart';
import 'package:tasky_todo_app/features/home/presentation/views/home_view.dart';
import 'package:tasky_todo_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:tasky_todo_app/features/profile/presentation/views/profile_view.dart';
import 'package:tasky_todo_app/features/splash/presentation/ui/views/spalsh_view.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashView:
        return MaterialPageRoute(builder: (_) => const SpalshView());

      case onboardingView:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case loginView:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case signupView:
        return MaterialPageRoute(builder: (_) => const SignupView());

      case profileView:
        return MaterialPageRoute(builder: (_) => const ProfileView());

      case homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());
    }
    return null;
  }
}
