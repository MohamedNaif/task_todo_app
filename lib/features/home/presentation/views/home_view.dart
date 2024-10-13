import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_todo_app/core/di/dependency_injection.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/features/home/data/models/task_model/task_model.dart';
import 'package:tasky_todo_app/features/home/data/repos/home_repo_impl.dart';
import 'package:tasky_todo_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final RefreshController _controller = RefreshController();
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
     final status = ModalRoute.of(context)?.settings.arguments ?? 'All';
    //  final List<TaskModel> todos = [];
    return BlocProvider(
      create: (context) => HomeCubit(getIt.get<HomeRepoImpl>()),
      child: SmartRefresher(
        controller:_controller ,
         onRefresh: () => _onRefresh(context, status.toString()),
        enablePullUp: true,
        child: Scaffold(
          body: SafeArea(child: HomeViewBody(status: status.toString(),)),
        ),
      ),
    );
  }
  

 Future <void> _onRefresh(BuildContext context, String status) async{
  await Future.delayed(const Duration(seconds: 1)).then(
      (_) {

        Navigator.pushNamedAndRemoveUntil(
          context,
         homeView,
          (route) => false,
          arguments: status,
        );
      },
    );
    _controller.refreshCompleted();
  }
}
