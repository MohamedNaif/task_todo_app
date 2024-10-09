import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky_todo_app/core/di/dependency_injection.dart';
import 'package:tasky_todo_app/core/helper/shared_pref.dart';
import 'package:tasky_todo_app/core/routing/app_routing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();
  await SharedPref.init();
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.onGenerateRoute,
      theme: ThemeData(
        fontFamily: GoogleFonts.dmSans().fontFamily,
      ),
    );
  }
}
