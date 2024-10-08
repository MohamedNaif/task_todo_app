import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';
import 'package:tasky_todo_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_todo_app/core/widgets/custom_button.dart';

import 'package:tasky_todo_app/core/widgets/custom_text_form_field.dart';

import 'package:tasky_todo_app/features/home/presentation/views/widgets/task_detailes_view_body.dart';

class AddTaskViewBody extends StatelessWidget {
  const AddTaskViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(AssetsDate.arrowLeft)),
            title: Text(
              'Add Task',
              style: AppStyle.textStyle19().copyWith(color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          _buidAddTaskViewBody(context),
        ],
      ),
    );
  }

  _buidAddTaskViewBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          const AddTaskImage(),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Task Title',
                style:
                    AppStyle.textStyle14().copyWith(color: Colors.grey[600])),
          ),
          const CustomTextFormField(
            obscureText: false,
            hintText: 'Enter Task Title here.....',
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('The Description',
                style:
                    AppStyle.textStyle14().copyWith(color: Colors.grey[600])),
          ),
          const CustomTextFormField(
            obscureText: false,
            maxLines: 7,
            hintText: 'Enter Task Title here.....',
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Priority',
                style:
                    AppStyle.textStyle14().copyWith(color: Colors.grey[600])),
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
              onTap: () {}),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Due Date',
                style:
                    AppStyle.textStyle14().copyWith(color: Colors.grey[600])),
          ),
          CustomTextFormField(
            suffixIcon: IconButton(
                onPressed: () {
                  _showDatePicker(context);
                },
                icon: Image.asset(AssetsDate.calendarImage)),
            obscureText: false,
            maxLines: 1,
            hintText: 'Choose Date',
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
          CustomButton(text: 'Add Task', onTap: () {}),
          const SizedBox(height: 20),
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

class AddTaskImage extends StatelessWidget {
  const AddTaskImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.07,
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: DottedBorder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [4, 4],
        color: primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsDate.addImage),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Add Image',
              style: AppStyle.textStyle19().copyWith(color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
