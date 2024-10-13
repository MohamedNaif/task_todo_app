import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky_todo_app/features/home/data/models/task_model/task_model.dart';
import 'package:tasky_todo_app/features/home/data/repos/task_detailes_repo.dart';

part 'task_detailes_state.dart';

class TaskDetailesCubit extends Cubit<TaskDetailesState> {
  TaskDetailesCubit(this.taskDetailsRepo) : super(TaskDetailesInitial());
  final TaskDetailsRepo taskDetailsRepo;
   bool isEdited = false;

  Future<void> getTaskDetailes({required String taskId}) async {
    
    emit(TaskDetailesLoading());
    final result = await taskDetailsRepo.getTaskDetailsData(taskId: taskId);
    result.fold(
      (error) => emit(TaskDetailesFailure(error.errMessage)),
      (success) => emit(TaskDetailesSuccess(success)),
    );
  }
}
