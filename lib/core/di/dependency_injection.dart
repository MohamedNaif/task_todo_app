import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tasky_todo_app/core/helper/api_services.dart';
import 'package:tasky_todo_app/features/auth/data/repos/auth_repo_impl.dart';

import 'package:tasky_todo_app/features/profile/data/repos/profile_repo_impl.dart';

final GetIt getIt = GetIt.instance;
void setupDependencyInjection() {
  // setup dependency injection

  getIt.registerSingleton<ApiServices>(ApiServices(Dio()));
  final apiServices = getIt.get<ApiServices>();

  getIt.registerSingleton<ProfileRepoImpl>(ProfileRepoImpl(apiServices));

  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl(apiServices));
}
