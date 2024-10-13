import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_todo_app/core/di/dependency_injection.dart';
import 'package:tasky_todo_app/core/function/show_snack_bar.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/helper/shared_pref.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';
import 'package:tasky_todo_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_todo_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:tasky_todo_app/features/auth/presentation/view_model/auth_cubit/auth_cubit_cubit.dart';
import 'package:tasky_todo_app/features/home/data/models/task_model/task_model.dart';
import 'package:tasky_todo_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/custom_task_card.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
    required this.status,
  });

  final String status;

  @override
  HomeViewBodyState createState() => HomeViewBodyState();
}

class HomeViewBodyState extends State<HomeViewBody> {
  String selectedFilter = 'All'; // Default filter
  late final ScrollController _scrollController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _setSelectedIndexValue();
    _triggerHomeCubit();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeSuccess) {
          return Stack(children: [
            Column(
              children: [
                BlocProvider(
                  create: (context) =>
                      AuthCubitCubit(getIt.get<AuthRepoImpl>()),
                  child: CustomAppBar(
                    title: Text(
                      "Logo",
                      style: AppStyle.textStyle24(),
                    ),
                    actions: [
                      Row(children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, profileView);
                          },
                          child: Image.asset(AssetsDate.profileImage),
                        ),
                        const SizedBox(width: 10),
                        BlocConsumer<AuthCubitCubit, AuthCubitState>(
                          listener: (context, state) {
                            if (state is LogoutSuccess) {
                              showSnackBar(context,
                                  message: 'Logout Success',
                                  color: Colors.green);
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                loginView,
                                (route) => false,
                              );
                            } else if (state is LogoutError) {
                              showSnackBar(context, message: state.errMessage);
                            }
                          },
                          builder: (context, state) {
                            return IconButton(
                              onPressed: () async {
                                await BlocProvider.of<AuthCubitCubit>(context)
                                    .logout();
                                // Logout function
                              },
                              icon: state is LogoutLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Icon(
                                      Icons.logout,
                                      color: primaryColor,
                                    ),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                      ])
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Filter Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      filterButton('All'),
                      filterButton('in progress'),
                      filterButton('waiting'),
                      filterButton('finished'),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Display tasks based on the selected filter
                Expanded(
                  child: state.tasks.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                'No tasks available!',
                                style: AppStyle.textStyle24()
                                    .copyWith(color: Colors.black),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'It looks like you haven’t created any tasks yet.',
                                style: AppStyle.textStyle12()
                                    .copyWith(color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount:
                              context.read<HomeCubit>().hasMoreTasks != false
                                  ? state.tasks.length + 1
                                  : state.tasks.length,
                          itemBuilder: (context, index) {
                            final task = state.tasks[index];
                            if (selectedFilter == 'All' ||
                                task.status == selectedFilter) {
                              return CustomHomeCard(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    taskDetailsView,
                                    arguments: task.id,
                                  );
                                },
                                title: task.title ?? '',
                                description: task.desc ?? '',
                                status: task.status ?? '',
                                date: task.createdAt?.toString() ?? '',
                                priority: task.priority ?? '',
                                containerColor:
                                    getContainerColor(task.status ?? ''),
                                iconColor: getIconColor(task.priority ?? ''),
                                priorityColor:
                                    getPriorityColor(task.priority ?? ''),
                                statusColor: getStatusColor(task.status ?? ''),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: primaryColor,
                onPressed: () {
                  Navigator.pushNamed(context, addTaskView);
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 90, // Position the second button higher
              right: 20,
              child: FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {
                  Navigator.pushNamed(context, qrView);
                },
                backgroundColor: const Color.fromRGBO(235, 229, 255, 1),
                child: SvgPicture.asset(AssetsDate.scaner),
              ),
            ),
          ]);
        } else if (state is HomeFailure) {
          return const Center(child: Text('Failed to load tasks.'));
        }
        return const Center(
            child: Text(
          'No tasks available.',
          style: TextStyle(
            color: Colors.black,
          ),
        ));
      },
    );
  }

  // Filter Button widget
  Widget filterButton(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: selectedFilter == label
              ? primaryColor
              : Colors.grey[300], // Change color when selected
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: AppStyle.textStyle14().copyWith(
            color: selectedFilter == label ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // Function to get color based on task status
  Color getContainerColor(String status) {
    switch (status) {
      case 'waiting':
        return const Color.fromRGBO(255, 228, 242, 1);
      case 'in progress':
        return const Color.fromRGBO(240, 236, 255, 1);
      case 'finished':
        return const Color.fromRGBO(227, 242, 255, 1);
      default:
        return Colors.grey[200]!;
    }
  }

  // Function to get status color
  Color getStatusColor(String status) {
    switch (status) {
      case 'waiting':
        return const Color.fromRGBO(255, 125, 83, 1);
      case 'inprogress' || 'in progress':
        return primaryColor;
      case 'finished':
        return const Color.fromRGBO(0, 135, 255, 1);
      default:
        return Colors.black;
    }
  }

  // Function to get priority color
  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return const Color.fromRGBO(255, 125, 83, 1);
      case 'medium':
        return primaryColor;
      case 'low':
        return const Color.fromRGBO(0, 135, 255, 1);
      default:
        return Colors.black;
    }
  }

  // Function to get icon color based on priority
  Color getIconColor(String priority) {
    switch (priority) {
      case 'high':
        return const Color.fromRGBO(255, 125, 83, 1);
      case 'medium':
        return primaryColor;
      case 'low':
        return const Color.fromRGBO(0, 135, 255, 1);
      default:
        return Colors.black;
    }
  }

  void _setSelectedIndexValue() async {
    if (widget.status.toLowerCase() == 'all') {
      await SharedPref.sharedPref.setInt(selectedIndex, 0);
    }
  }

  Future<void> _triggerHomeCubit() async {
    await BlocProvider.of<HomeCubit>(context)
        .getAllTasks(status: widget.status);
  }

  void _scrollListener() async {
    final currentPosition = _scrollController.position.pixels;
    final maxScrollLength = _scrollController.position.maxScrollExtent;
    final isNearEnd = currentPosition >= .75 * maxScrollLength;
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    if (isNearEnd && !isLoading && homeCubit.hasMoreTasks != false) {
      isLoading = true;
      await BlocProvider.of<HomeCubit>(context)
          .getAllTasks(status: widget.status);
      isLoading = false;
    }
  }
}
