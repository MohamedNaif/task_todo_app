import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky_todo_app/core/di/dependency_injection.dart';
import 'package:tasky_todo_app/core/function/show_snack_bar.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';
import 'package:tasky_todo_app/features/home/data/repos/upload_image_repo_impl.dart';
import 'package:tasky_todo_app/features/home/presentation/view_model/upload_image_cubit/upload_image_cubit.dart';

class AddTaskImage extends StatelessWidget {
  const AddTaskImage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCustomBottomSheet(context);
      },
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.07,
        width: MediaQuery.sizeOf(context).width * 0.8,
        child: DottedBorder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          dashPattern: const [4, 4],
          color: primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetsDate.addImage),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Add Image',
                style: AppStyle.textStyle19().copyWith(color: primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => UploadImageCubit(getIt.get<UploadImageRepoImpl>()),
        child: Builder(
          builder: (context) {
            return BlocConsumer<UploadImageCubit, UploadImageState>(
              listener: (context, state) {
                if (state is UploadImageSuccessState) {
                  showSnackBar(
                    context,
                    message: 'Image added successfully',
                    color: Colors.green,
                  );
                } else if (state is UploadImageFailureState) {
                  showSnackBar(
                    context,
                    message: state.errMessage,
                    color: Colors.red,
                  );
                }
              },
              builder: (context, state) {
                if (state is UploadImageLoadingState) {
                  return const SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.camera_alt),
                        title: const Text('Take a photo'),
                        onTap: () async {
                          await _pickImage(ImageSource.camera, context);
                          if (!context.mounted) return;
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text('Choose from gallery'),
                        onTap: () async {
                          await _pickImage(ImageSource.gallery, context);
                          if (!context.mounted) return;
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
              },
            );
          },
        ),
      );
    },
  );
}

Future<void> _pickImage(ImageSource source, BuildContext context) async {
  final uploadImageCubit = context.read<UploadImageCubit>();
  final pickedFile =
      await ImagePicker().pickImage(source: source, imageQuality: 50);
  if (pickedFile != null) {
    final imgFile = File(pickedFile.path);
    await uploadImageCubit.uploadImage(imgFile: imgFile);
  }
}
