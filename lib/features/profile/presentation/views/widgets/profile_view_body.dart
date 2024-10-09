import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';

import 'package:tasky_todo_app/core/theming/app_style.dart';
import 'package:tasky_todo_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_todo_app/features/profile/presentation/view_model/cubit/profile_cubit_cubit.dart';
import 'package:tasky_todo_app/features/profile/presentation/views/widgets/custom_card.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  void initState() {
    _triggerProfileCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubitCubit, ProfileCubitState>(
      builder: (context, state) {
        if (state is ProfileCubitError) {
          return Center(child: Text(state.errMessage));
        } else if (state is ProfileCubitSuccess) {
          return Column(
            children: [
              CustomAppBar(
                leading: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(AssetsDate.arrowLeft)),
                title: Text(
                  'Profile',
                  style: AppStyle.textStyle19().copyWith(color: Colors.black),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.06,
              ),
              CustomCard(
                lableText: 'NAME',
                valueText: state.userData.displayName ?? 'Mohamed Naif',
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              CustomCard(
                lableText: 'PHONE',
                valueText: state.userData.phone ?? '+20 123 456-7890',
                onTap: () {
                  // Copy phone number to clipboard
                  Clipboard.setData(
                      ClipboardData(text: state.userData.phone ?? ''));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Phone number copied to clipboard!')),
                  );
                },
                image: Image.asset(AssetsDate.copyIcon),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              CustomCard(
                lableText: 'LEVEL',
                valueText: state.userData.level ?? 'Senior',
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              CustomCard(
                  lableText: 'Years of experience',
                  valueText: state.userData.experienceYears.toString()),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              const CustomCard(
                lableText: 'LOCATION',
                valueText: 'Fayyum, Egypt',
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  
  void _triggerProfileCubit() async{
    await BlocProvider.of<ProfileCubitCubit>(context).getProfileData();
  }
}
