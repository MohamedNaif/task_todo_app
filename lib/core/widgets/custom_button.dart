


import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onTap});

  final String text ;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        height: MediaQuery.sizeOf(context).height * 0.07,
        width: MediaQuery.sizeOf(context).width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: primaryColor),
        child:  Center(
          child: Text(
                text,
                style: AppStyle.textStyle19(),
              ),
        ),
      ),
    );
  }
}
