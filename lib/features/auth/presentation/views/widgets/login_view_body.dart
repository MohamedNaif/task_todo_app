import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_todo_app/core/function/show_snack_bar.dart';
import 'package:tasky_todo_app/core/helper/assets.dart';
import 'package:tasky_todo_app/core/helper/constant.dart';
import 'package:tasky_todo_app/core/theming/app_style.dart';

import 'package:tasky_todo_app/core/widgets/custom_button.dart';
import 'package:tasky_todo_app/features/auth/data/models/register_model.dart';
import 'package:tasky_todo_app/features/auth/presentation/view_model/auth_cubit/auth_cubit_cubit.dart';
import 'package:tasky_todo_app/features/auth/presentation/views/widgets/account_check.dart';
import 'package:tasky_todo_app/core/widgets/custom_text_form_field.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String? phone, password;
  AutovalidateMode? autoValidateMode = AutovalidateMode.disabled;

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
              onSaved: (value) {
                phone = value;
              },
            ),
            const SizedBox(height: 30),
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
              onSaved: (value) {
                password = value;
              },
            ),
            const SizedBox(height: 30),
            BlocConsumer<AuthCubitCubit, AuthCubitState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  showSnackBar(context,
                      message: 'Login Success, Welcome', color: Colors.green);
                  Navigator.pushNamed(context, homeView);
                } else if (state is LoginError) {
                  showSnackBar(context,
                      message: state.errMessage, color: Colors.red);
                }
                
              },
              builder: (context, state) {
                return CustomButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      var model = Register(
                        phone: phone!,
                        password: password!,
                      );
                      await BlocProvider.of<AuthCubitCubit>(context)
                          .login(model);
                    } else {
                      showSnackBar(context,
                          message: 'Please enter the required fields',
                          color: Colors.red);
                      autoValidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  text:state is LoginLoading ? 'Loading...' : 'Sign In',
                );
              },
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
