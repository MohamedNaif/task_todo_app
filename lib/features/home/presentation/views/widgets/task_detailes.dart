import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/priority_and_date_row.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/title_and_status_row.dart';

class TaskDetailes extends StatelessWidget {
  const TaskDetailes({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.priority,
    this.iconColor,
    this.priorityColor,
    this.statusColor,
    this.containerColor,
  });

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
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.6,
      child: Column(
        children: [
          TitleAndStatusRow(
            title: title,
            status: status,
            containerColor: containerColor,
            statusColor: statusColor,
          ),
          Text(
            overflow: TextOverflow.ellipsis,
            description,
            maxLines: 1,
            style: AppStyle.textStyle14()
                .copyWith(color: const Color.fromRGBO(36, 37, 34, 0.6)),
          ),
          PriorityAndDateRow(
            date: date,
            priority: priority,
            iconColor: iconColor,
            priorityColor: priorityColor,
          )
        ],
      ),
    );
  }
}
