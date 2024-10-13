import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky_todo_app/features/profile/data/models/user_data.dart';
import 'package:tasky_todo_app/features/profile/data/repos/profile_repo.dart';

part 'profile_cubit_state.dart';

class ProfileCubitCubit extends Cubit<ProfileCubitState> {
  ProfileCubitCubit(this._profileRepo) : super(ProfileCubitInitial());

  final ProfileRepo _profileRepo;

  Future<void> getProfileData() async {
    emit(ProfileCubitLoading());
    final result = await _profileRepo.getProfileData();
    result.fold(
      (error) => emit(ProfileCubitError(error.errMessage)),
      (success) => emit(ProfileCubitSuccess(success)),
    );
  }
}
