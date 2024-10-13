part of 'task_detailes_cubit.dart';

@immutable
sealed class TaskDetailesState {}

final class TaskDetailesInitial extends TaskDetailesState {}

final class TaskDetailesLoading extends TaskDetailesState {}

final class TaskDetailesSuccess extends TaskDetailesState {

  final TaskModel taskModel;

  TaskDetailesSuccess(this.taskModel);
}

final class TaskDetailesFailure extends TaskDetailesState {
  final String errMessage;

  TaskDetailesFailure(this.errMessage);
}
