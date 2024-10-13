import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky_todo_app/features/home/data/models/task_model/task_model.dart';
import 'package:tasky_todo_app/features/home/data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeInitial());
  final HomeRepo _homeRepo;
  int _currentPage = 1;
  bool? hasMoreTasks;


   Future<void> getAllTasks({required String status}) async {
    if (hasMoreTasks == false) return;

    emit(_currentPage == 1 ? HomeLoading() : HomePaginationLoading());

    final result = await _homeRepo.getAllTasks(pageNumber: _currentPage);

    result.fold(
      (failure) {
        emit(_currentPage == 1
            ? HomeFailure(failure.errMessage)
            : HomePaginationFailure(failure.errMessage));
      },
      (success) {
        //Filter tasks by status
        if (status.toLowerCase() != 'all') {
          final filteredTasks = success
              .where(
                  (task) => task.status?.toLowerCase() == status.toLowerCase())
              .toList();
          success = filteredTasks;
        }
        //Check if there are more tasks for pagination
        if (success.isEmpty || success.length < 20) {
          hasMoreTasks = false;
        } else {
          _currentPage++;
        }
        emit(HomeSuccess( success));
      },
    );
  }


}
