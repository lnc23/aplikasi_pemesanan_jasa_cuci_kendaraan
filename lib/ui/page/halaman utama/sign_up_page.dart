// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazywash/cubit/auth_cubit.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:lazywash/ui/page/widgets/custom_button_back.dart';
import 'package:lazywash/ui/page/widgets/custom_text_form_field.dart';

import '../../../cubit/auth_state.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final TextEditingController no_telpController =
      TextEditingController(text: '');
  final TextEditingController alamatController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Widget back() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Row(
          children: [
            CustomButtonBack(onPressed: () {
              Navigator.pushNamed(context, '/sign_in');
            }),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                'Daftar',
                style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
              ),
            ),
          ],
        ),
      );
    }

    Widget inputSection() {
      Widget nameInput() {
        return CustomTextFormField(
          title: 'Full name',
          hinText: 'Your full name',
          controller: nameController,
        );
      }

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
          controller: passwordController,
          obscureText: true,
        );
      }

      Widget no_telppInput() {
        return CustomTextFormField(
          title: 'Phone Number',
          hinText: 'Your Number',
          controller: no_telpController,
        );
      }

      Widget alamatInput() {
        return CustomTextFormField(
          title: 'Home Address',
          hinText: 'Your Address',
          controller: alamatController,
        );
      }

      Widget submitButton() {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            } else if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: kRedColor, content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomButton(
              title: 'Sign Up',
              onPressed: () {
                context.read<AuthCubit>().signUp(
                    email: emailController.text,
                    password: passwordController.text,
                    name: nameController.text,
                    no_telp: no_telpController.text,
                    alamat: alamatController.text);
              },
            );
          },
        );
      }

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
            nameInput(),
            emailInput(),
            passwordInput(),
            no_telppInput(),
            alamatInput(),
            submitButton()
          ],
        ),
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
