// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazywash/cubit/auth_cubit.dart';
import 'package:lazywash/cubit/auth_state.dart';
import 'package:lazywash/services/storage_service.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:lazywash/ui/page/widgets/custom_text_form_field.dart';

import '../../../cubit/auth_state.dart';
import '../../../shared/theme.dart';

class EditProfilePenyedia extends StatelessWidget {
  EditProfilePenyedia({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController no_telpController =
      TextEditingController(text: '');
  final TextEditingController alamatController =
      TextEditingController(text: '');

  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference user = firestore.collection('userspenyedia');

    Widget title() {
      return Container(
        margin: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
        child: Text(
          'Edit Profile',
          style: blackTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semibold,
          ),
        ),
      );
    }

    Widget inputSection() {
      Widget nameInput() {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccessPenyedia) {
              nameController.text = state.userpenyedia.name;
              return CustomTextFormField(
                title: 'Nama',
                hinText: state.userpenyedia.name,
                controller: nameController,
              );
            } else {
              return SizedBox();
            }
          },
        );
      }

      Widget no_telppInput() {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccessPenyedia) {
              no_telpController.text = state.userpenyedia.no_telp;
              return CustomTextFormField(
                title: 'Phone Number',
                hinText: 'Your Number',
                controller: no_telpController,
              );
            } else {
              return SizedBox();
            }
          },
        );
      }

      Widget alamatInput() {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccessPenyedia) {
              alamatController.text = state.userpenyedia.alamat;
              return CustomTextFormField(
                title: 'Home Address',
                hinText: 'Your Addres',
                controller: alamatController,
              );
            } else {
              return SizedBox();
            }
          },
        );
      }

      Widget submitButton() {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessPenyedia) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home_penyedia', (route) => false);
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
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccessPenyedia) {
                  return CustomButton(
                    title: 'Save',
                    onPressed: () {
                      context.read<AuthCubit>().updateDataPenyedia(
                            email: state.userpenyedia.email,
                            password: state.userpenyedia.password,
                            name: nameController.text,
                            no_telp: no_telpController.text,
                            alamat: alamatController.text,
                          );
                    },
                  );
                } else {
                  return SizedBox();
                }
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
            no_telppInput(),
            alamatInput(),
            submitButton()
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SafeArea(
          child: SizedBox(
            height: 1000,
            width: 500,
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              children: [
                title(),
                inputSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
