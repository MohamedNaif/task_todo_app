import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/helper/shared_pref.dart';
import 'package:tasky_todo_app/features/home/data/repos/upload_image_repo.dart';

part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit(this._uploadImageRepo) : super(UploadImageInitialState());
  final UploadImageRepo _uploadImageRepo;

  Future uploadImage({required File imgFile}) async {
    emit(UploadImageLoadingState());
    final result = await _uploadImageRepo.uploadImage(imageFile: imgFile);
    result.fold(
      (failure) => emit(UploadImageFailureState(failure.errMessage)),
      (success) {
        SharedPref.sharedPref.setString(image, success);
        emit(UploadImageSuccessState());
      },
    );
  }
}
