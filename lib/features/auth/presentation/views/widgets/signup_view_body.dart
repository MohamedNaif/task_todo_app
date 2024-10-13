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

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String? selectedExperienceLevel;
  AutovalidateMode? autoValidateMode = AutovalidateMode.disabled;
  String? name, phone, password, address, experienceLevel;
  num? experienceYears;

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
        autovalidateMode: autoValidateMode,
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
            CustomTextFormField(
              obscureText: false,
              hintText: 'Name...',
              onSaved: (value) {
                name = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              obscureText: false,
              hintText: '123 456-7890',
              onSaved: (value) {
                phone = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
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
            CustomTextFormField(
              obscureText: false,
              hintText: 'Years of experience...',
              onSaved: (value) {
                experienceYears = num.parse(value!);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your years of experience';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            crateDropdownButton(context, experienceLevels),
            const SizedBox(height: 20),
            CustomTextFormField(
              obscureText: false,
              hintText: 'Address...',
              onSaved: (value) {
                address = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              obscureText: _obscureText,
              hintText: 'Password',
              onSaved: (value) {
                password = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              maxLines: 1,
              suffixIcon: IconButton(
                onPressed: _toggleVisibility,
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<AuthCubitCubit, AuthCubitState>(
              listener: (context, state) {
                if (state is RegisterError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errMessage),
                    backgroundColor: Colors.red,
                  ));
                } else if (state is RegisterSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Account created successfully'),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.pop(context);
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
                        displayName: name!,
                        experienceYears: experienceYears as int,
                        address: address!,
                        level: experienceLevel!.toLowerCase(),
                      );
                      await BlocProvider.of<AuthCubitCubit>(context)
                          .register(model);
                    } else {
                      showSnackBar(context,
                          message: 'Please enter the required fields',
                          color: Colors.red);
                      autoValidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  text: state is RegisterLoading ? 'Loading....' : 'Sign Up',
                );
              },
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

  SizedBox crateDropdownButton(
      BuildContext context, List<String> experienceLevels) {
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
            experienceLevel = newValue;
          });
        },
        validator: (value) {
          if (value == null) {
            return 'Please select your experience level';
          }
          return null;
        },
      ),
    );
  }
}
