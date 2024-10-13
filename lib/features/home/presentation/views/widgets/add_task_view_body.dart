import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasky_todo_app/core/function/show_snack_bar.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/helper/shared_pref.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';
import 'package:tasky_todo_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_todo_app/core/widgets/custom_button.dart';
import 'package:tasky_todo_app/core/widgets/custom_drop_bttn.dart';

import 'package:tasky_todo_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_todo_app/features/home/data/models/add_task_model.dart';
import 'package:tasky_todo_app/features/home/presentation/view_model/add_task_cubit/add_task_cubit_cubit.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/add_task_image.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/show_date.dart';

import 'package:tasky_todo_app/features/home/presentation/views/widgets/task_detailes_view_body.dart';

class AddTaskViewBody extends StatefulWidget {
  const AddTaskViewBody({super.key});

  @override
  State<AddTaskViewBody> createState() => _AddTaskViewBodyState();
}

class _AddTaskViewBodyState extends State<AddTaskViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode? autoValidateMode = AutovalidateMode.disabled;
  String? title, desc;
  String priority = 'Medium';
  DateTime? dueDate;

  @override
  void initState() {
    SharedPref.sharedPref.remove(image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: autoValidateMode,
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
          CustomTextFormField(
            obscureText: false,
            hintText: 'Enter Task Title here.....',
            onSaved: (value) {
              title = value;
            },
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('The Description',
                style:
                    AppStyle.textStyle14().copyWith(color: Colors.grey[600])),
          ),
          CustomTextFormField(
            obscureText: false,
            maxLines: 7,
            hintText: 'Enter Task Description here.....',
            onSaved: (value) {
              desc = value;
            },
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Priority',
                style:
                    AppStyle.textStyle14().copyWith(color: Colors.grey[600])),
          ),
          CustomContanier(
            title: Row(
              children: [
                const Icon(
                  Icons.flag_outlined,
                  color: primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  '$priority Priority',
                  style: AppStyle.textStyle19()
                      .copyWith(color: primaryColor, fontSize: 16),
                ),
              ],
            ),
            widget: CustomDropDownButton(
              onChanged: (value) {
                priority = value!;
                setState(() {});
              },
              items: const ['Low', 'Medium', 'High'],
              icon: Image.asset(AssetsDate.arrowDown),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Due Date',
                style:
                    AppStyle.textStyle14().copyWith(color: Colors.grey[600])),
          ),
          CustomTextFormField(
            suffixIcon: ShowDate(
              onValue: (value) {
                if (value != null && value != dueDate) {
                  setState(() {
                    dueDate = value;
                  });
                }
              },
              selectedDate: dueDate ?? DateTime.now(),
            ),
            obscureText: false,
            maxLines: 1,
            hintText: dueDate == null
                ? 'choose due date...'
                : DateFormat('d/M/yyyy').format(dueDate!),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
          BlocConsumer<AddTaskCubitCubit, AddTaskCubitState>(
            listener: (context, state) {
              if (state is AddTaskCubitSuccess) {
                showSnackBar(
                  context,
                  message: 'Task added successfully',
                  color: Colors.green,
                );
                Navigator.pushAndRemoveUntil(
                    context, homeView as Route<Object?>, (route) => false);
              }
              if (state is AddTaskCubitError) {
                showSnackBar(
                  context,
                  message: state.errMessage,
                  color: Colors.red,
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                  text: state is AddTaskCubitLoading ? 'Adding...' : 'Add Task',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      AddTaskModel model = AddTaskModel(
                        image: SharedPref.sharedPref.getString(image) ?? '',
                        title: title!,
                        desc: desc!,
                        priority: priority.toLowerCase(),
                        dueDate: dueDate?.toIso8601String(),
                      );
                      BlocProvider.of<AddTaskCubitCubit>(context)
                          .addTask(addTaskModel: model);
                    } else {
                      showSnackBar(
                        context,
                        message: 'Please enter the required fields',
                        color: Colors.red,
                      );
                      setState(() {
                        autoValidateMode = AutovalidateMode.always;
                      });
                    }
                  });
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
