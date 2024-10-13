import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky_todo_app/features/home/data/repos/delete_task_repo.dart';

part 'delete_state.dart';

class DeleteCubit extends Cubit<DeleteState> {
  DeleteCubit(this._deleteTaskRepo) : super(DeleteInitial());
  final DeleteTaskRepo _deleteTaskRepo;

  Future<void> deleteTask({required String taskId}) async {
    emit(DeleteLoading());
    final result = await _deleteTaskRepo.deleteTask(taskId: taskId);
    result.fold((error) => emit(DeleteFailure(error.errMessage)),
        (success) => emit(DeleteSuccess()));
  }
}
