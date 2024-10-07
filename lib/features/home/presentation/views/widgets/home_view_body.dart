import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';
import 'package:tasky_todo_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/custom_task_card.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  HomeViewBodyState createState() => HomeViewBodyState();
}

class HomeViewBodyState extends State<HomeViewBody> {
  String selectedFilter = 'All'; // Default filter

  final List<Map<String, String>> tasks = [
    {
      'title': 'Grocery Shopping App',
      'description': 'This application is designed for super shops.',
      'status': 'Waiting',
      'date': '30/12/2022',
      'priority': 'Medium'
    },
    {
      'title': 'Grocery Shopping App',
      'description': 'This application is designed for super shops.',
      'status': 'Waiting',
      'date': '30/12/2022',
      'priority': 'High'
    },
    {
      'title': 'Grocery Shopping App',
      'description': 'This application is designed for super shops.',
      'status': 'Inprogress',
      'date': '30/12/2022',
      'priority': 'Low'
    },
    {
      'title': 'Grocery Shopping App',
      'description': 'This application is designed for super shops.',
      'status': 'Finished',
      'date': '30/12/2022',
      'priority': 'Medium'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          CustomAppBar(
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
                    child: Image.asset(AssetsDate.profileImage)),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.logout,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(width: 10),
              ])
            ],
          ),
          const SizedBox(height: 20),

          // Filter Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                filterButton('All'),
                filterButton('Inprogress'),
                filterButton('Waiting'),
                filterButton('Finished'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Display tasks based on the selected filter
          Expanded(
            child: ListView(
              children: tasks
                  .where((task) =>
                      selectedFilter == 'All' ||
                      task['status'] == selectedFilter)
                  .map((task) => CustomHomeCard(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            taskDetailsView,
                            arguments: task,
                          );
                        },
                        title: task['title']!,
                        description: task['description']!,
                        status: task['status']!,
                        date: task['date']!,
                        priority: task['priority']!,
                        containerColor: getContainerColor(task['status']!),
                        iconColor: getIconColor(task['priority']!),
                        priorityColor: getPriorityColor(task['priority']!),
                        statusColor: getStatusColor(task['status']!),
                      ))
                  .toList(),
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
            // Action for the first button
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
            // Action for the second button
          },
          backgroundColor: const Color.fromRGBO(235, 229, 255, 1),
          child: SvgPicture.asset(AssetsDate.scaner),
        ),
      ),
    ]);
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
      case 'Waiting':
        return const Color.fromRGBO(255, 228, 242, 1);
      case 'Inprogress':
        return const Color.fromRGBO(240, 236, 255, 1);
      case 'Finished':
        return const Color.fromRGBO(227, 242, 255, 1);
      default:
        return Colors.grey[200]!;
    }
  }

  // Function to get status color
  Color getStatusColor(String status) {
    switch (status) {
      case 'Waiting':
        return const Color.fromRGBO(255, 125, 83, 1);
      case 'Inprogress':
        return primaryColor;
      case 'Finished':
        return const Color.fromRGBO(0, 135, 255, 1);
      default:
        return Colors.black;
    }
  }

  // Function to get priority color
  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return const Color.fromRGBO(255, 125, 83, 1);
      case 'Medium':
        return primaryColor;
      case 'Low':
        return const Color.fromRGBO(0, 135, 255, 1);
      default:
        return Colors.black;
    }
  }

  Color getIconColor(String priority) {
    switch (priority) {
      case 'High':
        return const Color.fromRGBO(255, 125, 83, 1);
      case 'Medium':
        return primaryColor;
      case 'Low':
        return const Color.fromRGBO(0, 135, 255, 1);
      default:
        return Colors.black;
    }
  }
}
