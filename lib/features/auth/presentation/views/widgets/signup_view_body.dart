import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';
import 'package:tasky_todo_app/core/widgets/custom_button.dart';
import 'package:tasky_todo_app/features/auth/presentation/views/widgets/login_view_body.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
bool _obscureText = true;
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
    return  SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.55,
              width: MediaQuery.sizeOf(context).width,
              child: Image.asset(AssetsDate.artImage)),
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
              Navigator.pushNamed(context, loginView);
            },
            text: 'Sign In',
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have an account?'),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, signupView);
                },
                child: Text(
                  'Sign Up here',
                  style: AppStyle.textStyle14().copyWith(
                    color: primaryColor,
                    fontSize: 16, // Primary color for this part

                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline, // Underline
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
        
      
    );
  }
}