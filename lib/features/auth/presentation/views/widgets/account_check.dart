


import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';

class AccountCheck extends StatelessWidget {
  const AccountCheck({
    super.key,
    required this.haveAccount,
    required this.signUpOrSignIn,
    required this.onPressed,
  });

  final String haveAccount;
  final String signUpOrSignIn;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(haveAccount),
        TextButton(
          onPressed: onPressed,
          child: Text(
            signUpOrSignIn,
            style: AppStyle.textStyle14().copyWith(
              color: primaryColor,
              fontSize: 16, // Primary color for this part

              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline, // Underline
            ),
          ),
        ),
      ],
    );
  }
}
