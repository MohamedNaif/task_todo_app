import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/helper/shared_pref.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';
import 'package:tasky_todo_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_todo_app/core/widgets/custom_drop_bttn.dart';
import 'package:tasky_todo_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_todo_app/features/home/data/models/edit_task_model.dart';
import 'package:tasky_todo_app/features/home/data/models/task_model/task_model.dart';
import 'package:tasky_todo_app/features/home/presentation/view_model/edit_task/edit_task_cubit.dart';
import 'package:tasky_todo_app/features/home/presentation/view_model/task_detailes/task_detailes_cubit.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/custom_card_Task_detailes.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/custom_pop_menu_bttn.dart';
import 'package:tasky_todo_app/features/home/presentation/views/widgets/show_date.dart';

class TaskDetailesViewBody extends StatefulWidget {
  const TaskDetailesViewBody({
    super.key,
    required this.taskId,
  });
  final String taskId;

  @override
  State<TaskDetailesViewBody> createState() => _TaskDetailesViewBodyState();
}

class _TaskDetailesViewBodyState extends State<TaskDetailesViewBody> {
  String? title, desc, priority, status;

  @override
  void initState() {
    SharedPref.sharedPref.remove(image);
    _triggerTaskDetailsCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailesCubit, TaskDetailesState>(
      builder: (context, state) {
        if (state is TaskDetailesFailure) {
          return Center(
            child: Text(state.errMessage),
          );
        } else if (state is TaskDetailesSuccess) {
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
                _buidTaskDetailesViewBody(context, state.taskModel),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _buidTaskDetailesViewBody(
    BuildContext context,
    TaskModel task,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(task.image ?? AssetsDate.taskImage),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              task.title ?? 'Grocery Shopping App',
              style: AppStyle.textStyle24(),
            ),
          ),
          Text(
            task.desc ??
                'This application is designed for super shops. By using this application they can enlist all their products in one place and can deliver. Customers will get a one-stop solution for their daily shopping.',
            style: AppStyle.textStyle14()
                .copyWith(color: const Color.fromRGBO(36, 37, 44, 0.6)),
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            suffixIcon: ShowDate(
              onValue: (value) {
                if (value != null && value != task.createdAt) {
                  setState(() {
                    task.createdAt = value;
                  });
                }
              },
              selectedDate: task.createdAt ?? DateTime.now(),
            ),
            obscureText: false,
            maxLines: 1,
            hintText: task.createdAt == null
                ? 'choose due date...'
                : DateFormat('d/M/yyyy').format(task.createdAt!),
          ),

          const SizedBox(height: 10),
          CustomContanier(
            title: Text(
              'Inprogress',
              style: AppStyle.textStyle19()
                  .copyWith(color: primaryColor, fontSize: 16),
            ),
          ),
          CustomContanier(
            title: Row(
              children: [
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
                if (value != status) {
                  _editModel(context, newStatus: value, task);
                  setState(() {
                    status = value!;
                  });
                }
              },
              items: const ['Low', 'Medium', 'High'],
              icon: Image.asset(AssetsDate.arrowDown),
            ),
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
          const SizedBox(height: 10),
          QrImageView(
            padding: const EdgeInsets.all(16),
            data: task.id!,
          ),
          // Image.asset(AssetsDate.qrCode),
        ],
      ),
    );
  }

  Future _triggerTaskDetailsCubit() async {
    await BlocProvider.of<TaskDetailesCubit>(context)
        .getTaskDetailes(taskId: widget.taskId);
  }

  void _editModel(
    BuildContext context,
    TaskModel task, {
    String? newStatus,
    String? newPriority,
  }) {
    final EditTaskModel newModel = EditTaskModel(
      image: task.image!,
      title: task.title!,
      desc: task.desc!,
      priority: newPriority ?? task.priority!,
      status: newStatus ?? task.status!,
      user: task.user!,
    );
    context.read<EditTaskCubit>().editTask(
          editTaskModel: newModel,
          taskId: task.id!,
        );
    context.read<TaskDetailesCubit>().isEdited = true;
  }
}

class CustomContanier extends StatelessWidget {
  const CustomContanier({
    super.key,
    this.widget,
    this.title,
    this.subtitle,
  });

  final Widget? widget;
  final Widget? title;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(top: 7, bottom: 7, left: 24, right: 13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(240, 236, 255, 1),
      ),
      child: Center(
        child: ListTile(
          minVerticalPadding: 0,
          minTileHeight: 0,
          contentPadding: EdgeInsets.zero,
          title: title,
          subtitle: subtitle,
          trailing: widget,
        ),
      ),
    );
  }
}
