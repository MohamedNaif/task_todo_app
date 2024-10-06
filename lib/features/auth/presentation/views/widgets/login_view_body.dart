import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';
import 'package:tasky_todo_app/core/widgets/custom_button.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
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
              Navigator.pushNamed(context, homeView);
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

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.obscureText,
      this.labelText,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon});

  final bool obscureText;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.07,
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
