import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';

class CustomCardTaskDetailes extends StatelessWidget {
  const CustomCardTaskDetailes({
    super.key,
    required this.lableText,
    required this.valueText,
    this.image,
    this.onTap,
  });

  final String lableText;
  final String valueText;
  final Image? image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: MediaQuery.sizeOf(context).height * 0.09,
        width: MediaQuery.sizeOf(context).width * 0.8,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(240, 236, 255, 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lableText, style: AppStyle.textStyle12()),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  valueText,
                  style: AppStyle.textStyle12().copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: (Colors.black),
                  ),
                )
              ],
            ),
            const Spacer(),
            GestureDetector(onTap: onTap, child: SizedBox(child: image)),
          ],
        ));
  }
}
