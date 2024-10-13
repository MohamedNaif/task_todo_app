import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:tasky_todo_app/core/errors/app_errors.dart';
import 'package:tasky_todo_app/features/home/data/models/edit_task_model.dart';
import 'package:tasky_todo_app/features/home/data/repos/edit_task_repo.dart';

part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit(this.editTaskRepo) : super(EditTaskInitial());

   final EditTaskRepo editTaskRepo;

  Future editTask(
      {required EditTaskModel editTaskModel, required String taskId}) async {
    emit(EditTaskLoading());
    final result = await editTaskRepo.editTask(
        editTaskModel: editTaskModel, taskId: taskId);
    result.fold(
      (failure) => emit(EditTaskFailure(failure.errMessage)),
      (success) => emit(EditTaskSuccess()),
    );
  }
}
