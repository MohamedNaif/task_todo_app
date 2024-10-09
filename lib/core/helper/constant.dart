import 'package:flutter/material.dart';

const String accessToken = 'accessToken';
const String refreshToken = 'refreshToken';
const splashView = '/';
const onboardingView = '/onboarding';
const loginView = '/login';
const signupView = '/signup';
const homeView = '/home';
const taskDetailsView = '/taskDetails';
const addTaskView = '/addTask';
const profileView = '/profile';
const primaryColor = Color(0xFF5F33E1);
const secondaryColor = Color.fromRGBO(245, 245, 245, 1);

abstract class EndPoints {
  static const String register = 'auth/register';
  static const String login = 'auth/login';
  static const String logout = 'auth/logout';
  static const String refreshToken = 'auth/refresh-token';
  static const String profile = 'auth/profile';
  static const String todos = 'todos';
  static const String uploadImg = 'upload/image';
}
