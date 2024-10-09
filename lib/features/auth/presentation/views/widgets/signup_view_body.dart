import 'package:flutter/material.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';

import 'package:tasky_todo_app/core/widgets/custom_button.dart';
import 'package:tasky_todo_app/features/auth/presentation/views/widgets/account_check.dart';
import 'package:tasky_todo_app/core/widgets/custom_text_form_field.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String? selectedExperienceLevel;

  List<String> experienceLevels = ['Junior', 'Senior', 'Team Leader'];
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
                  child: Text('Sign Up', style: AppStyle.textStyle24())),
            ),
            const SizedBox(height: 20),
            const CustomTextFormField(
              obscureText: false,
              hintText: 'Name...',
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            const CustomTextFormField(
              obscureText: false,
              hintText: 'Years of experience...',
            ),
            const SizedBox(height: 20),
            crateDropdownButton(context),
            const SizedBox(height: 20),
            const CustomTextFormField(
              obscureText: false,
              hintText: 'Address...',
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              obscureText: _obscureText,
              hintText: 'Password',
              maxLines: 1,
              suffixIcon: IconButton(
                onPressed: _toggleVisibility,
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, loginView);
              },
              text: 'Sign Up',
            ),
            const SizedBox(height: 10),
            AccountCheck(
              haveAccount: 'Already have any account?',
              signUpOrSignIn: 'Sign in',
              onPressed: () {
                Navigator.pushNamed(context, loginView);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  SizedBox crateDropdownButton(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.07,
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          labelText: 'Choose experience Level',
        ),
        value: selectedExperienceLevel,
        items: experienceLevels.map((String level) {
          return DropdownMenuItem<String>(
            value: level,
            child: Text(level),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedExperienceLevel = newValue;
          });
        },
      ),
    );
  }
}
