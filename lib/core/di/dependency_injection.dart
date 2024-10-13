import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tasky_todo_app/core/helper/api_services.dart';
import 'package:tasky_todo_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:tasky_todo_app/features/home/data/repos/add_task_repo_impl.dart';
import 'package:tasky_todo_app/features/home/data/repos/delete_task_repo_impl.dart';
import 'package:tasky_todo_app/features/home/data/repos/edit_task_repo_impl.dart';
import 'package:tasky_todo_app/features/home/data/repos/home_repo_impl.dart';
import 'package:tasky_todo_app/features/home/data/repos/task_detailes_repo_impl.dart';
import 'package:tasky_todo_app/features/home/data/repos/upload_image_repo_impl.dart';

import 'package:tasky_todo_app/features/profile/data/repos/profile_repo_impl.dart';

final GetIt getIt = GetIt.instance;
void setupDependencyInjection() {
  // setup dependency injection

  getIt.registerSingleton<ApiServices>(ApiServices(Dio()));
  final apiServices = getIt.get<ApiServices>();

  getIt.registerSingleton<ProfileRepoImpl>(ProfileRepoImpl(apiServices));

  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl(apiServices));

  getIt.registerSingleton<AddTaskRepoImpl>(AddTaskRepoImpl(apiServices));

  getIt
      .registerSingleton<UploadImageRepoImpl>(UploadImageRepoImpl(apiServices));

  getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(apiServices));
  getIt.registerSingleton<DeleteTaskRepoImpl>(DeleteTaskRepoImpl(apiServices));
  getIt.registerSingleton<TaskDetailsRepoImpl>(TaskDetailsRepoImpl(apiServices));
   getIt.registerSingleton<EditTaskRepoImpl>(EditTaskRepoImpl(apiServices));
}
