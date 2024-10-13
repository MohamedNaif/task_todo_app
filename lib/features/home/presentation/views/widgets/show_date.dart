

import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';

class ShowDate extends StatelessWidget {
  const ShowDate(
      {super.key, required this.onValue, required this.selectedDate});

  final Function(DateTime?) onValue;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          _showDatePiker(context);
        },
        child: Image.asset(AssetsDate.calendarImage));
  }

  void _showDatePiker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2036),
    ).then(onValue);
  }
}
