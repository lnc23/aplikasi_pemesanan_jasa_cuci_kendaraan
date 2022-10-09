// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazywash/cubit/auth_cubit.dart';
import 'package:lazywash/services/storage_service.dart';
import 'package:lazywash/ui/page/user/profile_page.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:lazywash/ui/page/widgets/custom_text_form_field.dart';
import '../../../cubit/auth_state.dart';
import '../../../shared/theme.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
    CollectionReference user = firestore.collection('users');

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
            if (state is AuthSuccess) {
              nameController.text = state.user.name;
              return CustomTextFormField(
                title: 'Nama',
                hinText: state.user.name,
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
            if (state is AuthSuccess) {
              no_telpController.text = state.user.no_telp;
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
            if (state is AuthSuccess) {
              alamatController.text = state.user.alamat;
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

      Widget addPhoto() {
        final Storage storage = Storage();
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              var imagename = state.user.id;
              return Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: Column(
                        children: [
                          CustomButton(
                            title: 'Upload Photo',
                            onPressed: () async {
                              final results = await FilePicker.platform
                                  .pickFiles(
                                      allowMultiple: false,
                                      type: FileType.custom,
                                      allowedExtensions: ['png', 'jpg']);

                              if (results == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("No Picture Selected"),
                                  ),
                                );
                                return null;
                              }

                              final path = results.files.single.path!;
                              final filename = imagename;

                              storage.uploadImage(path, filename);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
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
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            } else if (state is AuthFailed) {
              User? user = FirebaseAuth.instance.currentUser;
              context.read<AuthCubit>().getCurrentUser(user!.uid);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
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
                if (state is AuthLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is AuthSuccess) {
                  return CustomButton(
                    title: 'Save',
                    onPressed: () {
                      context.read<AuthCubit>().updateData(
                            email: state.user.email,
                            password: state.user.password,
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
            addPhoto(),
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
              children: [title(), inputSection()],
            ),
          ),
        ),
      ),
    );
  }
}
