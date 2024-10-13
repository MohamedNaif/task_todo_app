part of 'upload_image_cubit.dart';

@immutable
sealed class UploadImageState {}

final class UploadImageInitialState extends UploadImageState {}

final class UploadImageLoadingState extends UploadImageState {}

final class UploadImageSuccessState extends UploadImageState {}

final class UploadImageFailureState extends UploadImageState {
  final dynamic errMessage;

  UploadImageFailureState(this.errMessage);
}
