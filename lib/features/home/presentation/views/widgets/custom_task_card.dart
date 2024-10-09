import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';

import 'package:tasky_todo_app/features/home/presentation/views/widgets/custom_pop_menu_bttn.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/task_detailes.dart';

class CustomHomeCard extends StatelessWidget {
  const CustomHomeCard(
      {super.key,
      required this.title,
      required this.description,
      required this.status,
      required this.date,
      required this.priority,
      this.iconColor,
      this.priorityColor,
      this.statusColor,
      this.containerColor,
      required this.onTap});

  final String title;
  final String description;
  final String status;
  final String date;
  final String priority;
  final Color? iconColor;
  final Color? priorityColor;
  final VoidCallback onTap;

  final Color? statusColor;
  final Color? containerColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage(AssetsDate.homeImage),
          ),
          const SizedBox(width: 10),
          TaskDetailes(
            title: title,
            description: description,
            status: status,
            date: date,
            priority: priority,
            containerColor: containerColor,
            iconColor: iconColor,
            priorityColor: priorityColor,
            statusColor: statusColor,
          ),
          const Spacer(),
          const CustomPopMenuButton()
        ]),
      ),
    );
  }
}
