// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lazywash/cubit/auth_cubit.dart';
import 'package:lazywash/cubit/page_cubit.dart';
import 'package:lazywash/services/storage_service.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazywash/ui/page/widgets/custom_form_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../cubit/auth_state.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final Storage storage = Storage();

  Widget header1() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          var imageurl = "";
          var imagename = state.user.id;
          return FutureBuilder(
            ///download  url image berdasarkan id user
            future: storage.downloadURL('$imagename'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                imageurl = snapshot.data!;
              }
              return Container(
                margin: EdgeInsets.only(
                  top: 30,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hallo, \n${state.user.name}',
                            style: blackTextStyle.copyWith(
                              fontSize: 24,
                              fontWeight: semibold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(imageurl),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget header2() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Row(
        children: [
          Text(
            'Profile',
            style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
          ),
        ],
      ),
    );
  }

  Widget nama() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return CustomFormDetail(
            title: 'Nama',
            isi: state.user.name,
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget email() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return CustomFormDetail(
            title: 'Email',
            isi: state.user.email,
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget no_telp() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return CustomFormDetail(
            title: 'No.Telp',
            isi: state.user.no_telp,
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget alamat() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return CustomFormDetail(
            title: 'Alamat Lengkap',
            isi: state.user.alamat,
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: kRedColor, content: Text(state.error)));
        } else if (state is AuthInitial) {
          context.read<PageCubit>().setPage(0);
          Navigator.pushNamedAndRemoveUntil(
              context, '/sign_in', (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Scaffold(
            backgroundColor: kBackgroundColor,
            body: SafeArea(
              child: ListView(
                padding: EdgeInsets.only(
                    left: defaultMargin, right: defaultMargin, top: 35),
                children: [
                  header1(),
                  header2(),
                  nama(),
                  email(),
                  no_telp(),
                  alamat(),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    title: 'Edit Profile',
                    onPressed: () {
                      Navigator.pushNamed(context, '/edit_profile');
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomButton(
                    title: 'Sign Out',
                    onPressed: () async {
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();

                      ///value login dihapus jadi null
                      sharedPreferences.remove("value");
                      context.read<AuthCubit>().signOut();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
