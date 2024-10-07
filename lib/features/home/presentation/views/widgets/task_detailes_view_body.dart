import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';
import 'package:tasky_todo_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/custom_card_Task_detailes.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/custom_pop_menu_bttn.dart';

class TaskDetailesViewBody extends StatelessWidget {
  const TaskDetailesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(
            title: Text(
              'Task Details',
              style: AppStyle.textStyle19().copyWith(color: Colors.black),
            ),
            actions: const [CustomPopMenuButton()],
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(AssetsDate.arrowLeft)),
          ),
          const SizedBox(height: 20),
          _buidTaskDetailesViewBody(context),
        ],
      ),
    );
  }

  _buidTaskDetailesViewBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AssetsDate.taskImage),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Grocery Shopping App',
              style: AppStyle.textStyle24(),
            ),
          ),
          Text(
            'This application is designed for super shops. By using this application they can enlist all their products in one place and can deliver. Customers will get a one-stop solution for their daily shopping.',
            style: AppStyle.textStyle14()
                .copyWith(color: const Color.fromRGBO(36, 37, 44, 0.6)),
          ),
          const SizedBox(height: 10),
          CustomCardTaskDetailes(
              image: Image.asset(AssetsDate.calendarImage),
              onTap: () {
                _showDatePicker(context);
              },
              lableText: 'End Date',
              valueText: '30/12/2022'),
          const SizedBox(height: 10),
          CustomContanier(
            widget: Text(
              'Inprogress',
              style: AppStyle.textStyle19()
                  .copyWith(color: primaryColor, fontSize: 16),
            ),
            onTap: () {},
          ),
          CustomContanier(
            widget: Row(
              children: [
                const Icon(
                  Icons.flag_outlined,
                  color: primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Medium Priority',
                  style: AppStyle.textStyle19()
                      .copyWith(color: primaryColor, fontSize: 16),
                ),
              ],
            ),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          Image.asset(AssetsDate.qrCode),
        ],
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
  }
}

class CustomContanier extends StatelessWidget {
  const CustomContanier({
    super.key,
    required this.widget,
    required this.onTap,
  });

  final Widget widget;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.08,
      width: MediaQuery.sizeOf(context).width * 0.8,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(240, 236, 255, 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              widget,
              const Spacer(),
              Image.asset(AssetsDate.arrowDown),
            ],
          ),
        ),
      ),
    );
  }
}
