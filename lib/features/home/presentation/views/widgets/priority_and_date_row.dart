


import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';

class PriorityAndDateRow extends StatelessWidget {
  const PriorityAndDateRow({
    super.key,
    this.iconColor,
    required this.date,
    required this.priority,
    this.priorityColor,
  });

  final Color? iconColor;

  final String date;
  final String priority;
  final Color? priorityColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.flag_outlined,
          color: iconColor,
        ),
        const SizedBox(width: 5),
        Text(
          priority,
          style: AppStyle.textStyle12().copyWith(
            color: priorityColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Text(
          date,
          style: AppStyle.textStyle12()
              .copyWith(color: const Color.fromRGBO(36, 37, 34, 0.6)),
        ),
      ],
    );
  }
}
