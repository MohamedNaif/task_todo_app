


import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';

class TitleAndStatusRow extends StatelessWidget {
  const TitleAndStatusRow({
    super.key,
    required this.title,
    required this.status,
    this.statusColor,
    this.containerColor,
  });

  final String title;
  final String status;
  final Color? statusColor;
  final Color? containerColor;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(36, 37, 44, 1),
              fontWeight: FontWeight.w700),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Container(
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: containerColor),
        child: Text(
          status,
          style: AppStyle.textStyle12()
              .copyWith(color: statusColor, fontWeight: FontWeight.w600),
        ),
      ),
    ]);
  }
}
