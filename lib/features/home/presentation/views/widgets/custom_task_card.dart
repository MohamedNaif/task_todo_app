import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';
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
      this.containerColor});

  final String title;
  final String description;
  final String status;
  final String date;
  final String priority;
  final Color? iconColor;
  final Color? priorityColor;

  final Color? statusColor;
  final Color? containerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        PopupMenuButton(
          icon: const Icon(Icons.more_vert_outlined, color: Colors.black),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              child: Text(
                'Edit',
                style: AppStyle.textStyle14().copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Text(
                'Delete',
                style: AppStyle.textStyle14().copyWith(
                    color: const Color.fromRGBO(255, 125, 83, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'edit') {
              // Handle edit action
              print('Edit action clicked');
            } else if (value == 'delete') {
              // Handle delete action
              print('Delete action clicked');
            }
          },
        )
      ]),
    );
  }
}
