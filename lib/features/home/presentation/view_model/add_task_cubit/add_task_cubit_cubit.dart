import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky_todo_app/features/home/data/models/add_task_model.dart';
import 'package:tasky_todo_app/features/home/data/repos/add_task_repo.dart';

part 'add_task_cubit_state.dart';

class AddTaskCubitCubit extends Cubit<AddTaskCubitState> {
  AddTaskCubitCubit(this._addTaskRepo) : super(AddTaskCubitInitial());
  final AddTaskRepo _addTaskRepo;
  String? image;

  Future<void> addTask({required AddTaskModel addTaskModel}) async {
    emit(AddTaskCubitLoading());
    final result = await _addTaskRepo.addTask(addTaskModel: addTaskModel);
    result.fold(
      (error) => emit(AddTaskCubitError(error.errMessage)),
      (success) => emit(AddTaskCubitSuccess()),
    );
  }
}
