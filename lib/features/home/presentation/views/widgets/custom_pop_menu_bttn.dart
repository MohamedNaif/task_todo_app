


import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';

class CustomPopMenuButton extends StatelessWidget {
  const CustomPopMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
    );
  }
}
