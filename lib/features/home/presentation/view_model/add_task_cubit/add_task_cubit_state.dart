part of 'add_task_cubit_cubit.dart';

@immutable
sealed class AddTaskCubitState {}

final class AddTaskCubitInitial extends AddTaskCubitState {}

class AddTaskCubitLoading extends AddTaskCubitState {}

class AddTaskCubitSuccess extends AddTaskCubitState {}

class AddTaskCubitError extends AddTaskCubitState {
  final String errMessage;

  AddTaskCubitError(this.errMessage);
}
