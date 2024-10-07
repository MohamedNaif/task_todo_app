import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';

import 'package:tasky_todo_app/core/theming/app_style.dart';
import 'package:tasky_todo_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_todo_app/features/profile/presentation/views/widgets/custom_card.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
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
        const CustomCard(
          lableText: 'NAME',
          valueText: 'Islam Sayed',
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.03,
        ),
        CustomCard(
          lableText: 'PHONE',
          valueText: '+20 123 456-7890',
          onTap: () {
            // Copy phone number to clipboard
            Clipboard.setData(const ClipboardData(text: '+20 123 456-7890'));
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
        const CustomCard(
          lableText: 'LEVEL',
          valueText: 'Senior',
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.03,
        ),
        const CustomCard(
          lableText: 'Years of experience',
          valueText: '7 years',
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.03,
        ),
        const CustomCard(
          lableText: 'LOCATION',
          valueText: 'Fayyum, Egypt',
        ),
      ],
    );
  }
}
