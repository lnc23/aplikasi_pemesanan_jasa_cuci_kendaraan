// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazywash/cubit/auth_cubit.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:lazywash/ui/page/widgets/custom_button_back.dart';
import 'package:lazywash/ui/page/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../cubit/auth_state.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');

  static bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    Widget back() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Row(
          children: [
            CustomButtonBack(onPressed: () {
              Navigator.pushNamed(context, '/get-started');
            }),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                'Login',
                style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
              ),
            ),
          ],
        ),
      );
    }

    Widget inputSection() {
      Widget emailInput() {
        return CustomTextFormField(
          title: 'Email Address',
          hinText: 'Your email address',
          controller: emailController,
        );
      }

      Widget passwordInput() {
        return CustomTextFormField(
          title: 'Password',
          hinText: 'Your password',
          obscureText: true,
          controller: passwordController,
        );
      }

      Widget signinbutton() {
        ///nilai false untuk login pengguna dan nilai true untuk login penyedia jasa dan admin
        if (isSwitched == false) {
          return CustomButton(
            title: 'Sign In',
            onPressed: () async {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.setInt("value", 1);
              context.read<AuthCubit>().signIn(
                    email: emailController.text,
                    password: passwordController.text,
                  );
            },
          );
        } else if (isSwitched == true) {
          return CustomButton(
            title: 'Sign In',
            onPressed: () async {
              if (emailController.text == "admin_xyz@gmail.com") {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setInt("value", 3);
                context.read<AuthCubit>().signInAdmin(
                      email: emailController.text,
                      password: passwordController.text,
                    );
              } else {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setInt("value", 2);
                context.read<AuthCubit>().signInPenyedia(
                      email: emailController.text,
                      password: passwordController.text,
                    );
              }
            },
          );
        } else {
          return SizedBox();
        }
      }

      Widget daftar() {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sign_up');
                },
                child: Text(
                  'Pengguna Baru',
                  style: greyTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: light,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        );
      }

      Widget keterangan() {
        if (isSwitched == false) {
          return Container(
            child: Text(
              "Login User",
              style: blackTextStyle.copyWith(fontSize: 12),
            ),
          );
        } else if (isSwitched == true) {
          return Container(
            child: Text(
              "Login Penyedia",
              style: blackTextStyle.copyWith(fontSize: 12),
            ),
          );
        } else {
          return SizedBox();
        }
      }

      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          } else if (state is AuthSuccessPenyedia) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home_penyedia', (route) => false);
          } else if (state is AuthSuccessAdmin) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/admin', (route) => false);
          } else if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: kRedColor,
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(
                defaultRadius,
              ),
            ),
            child: Column(
              children: [
                emailInput(),
                passwordInput(),
                signinbutton(),
                SizedBox(
                  height: 15,
                ),
                CustomSwitch(
                  value: isSwitched,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(
                      () {
                        isSwitched = value;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                keterangan(),
                daftar(),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          children: [
            back(),
            inputSection(),
          ],
        ),
      ),
    );
  }
}
