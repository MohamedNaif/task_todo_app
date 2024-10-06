import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';

import 'package:tasky_todo_app/core/widgets/custom_button.dart';
import 'package:tasky_todo_app/features/auth/presentation/views/widgets/account_check.dart';
import 'package:tasky_todo_app/features/auth/presentation/views/widgets/custom_text_form_field.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  // Toggle password visibility
  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String generateCountryFlag() {
    String countryCode = 'eg';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.55,
                width: MediaQuery.sizeOf(context).width,
                child: Image.asset(AssetsDate.artImage)),
            Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.sizeOf(context).width * 0.1),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Login', style: AppStyle.textStyle24())),
            ),
            const SizedBox(height: 30),
            CustomTextFormField(
              obscureText: false,
              hintText: '123 456-7890',
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${generateCountryFlag()} +20'),
                    const Icon(Icons.keyboard_arrow_down_outlined,
                        color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            CustomTextFormField(
              obscureText: _obscureText,
              hintText: 'Password',
              suffixIcon: IconButton(
                onPressed: _toggleVisibility,
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, homeView);
              },
              text: 'Sign In',
            ),
            const SizedBox(height: 10),
            AccountCheck(
              haveAccount: 'Didn’t have any account?',
              signUpOrSignIn: 'Sign Up here',
              onPressed: () {
                Navigator.pushNamed(context, signupView);
              },
            ),
          ],
        ),
      ),
    );
  }
}
