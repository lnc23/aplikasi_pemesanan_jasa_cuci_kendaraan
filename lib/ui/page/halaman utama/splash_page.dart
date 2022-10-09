// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lazywash/cubit/auth_cubit.dart';
import 'package:lazywash/cubit/harga_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

int? value = 0;

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState

    getvalidationData().whenComplete(() async {
      Timer(Duration(seconds: 3), () {
        User? user = FirebaseAuth.instance.currentUser;

        if (value == null || user == null) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/get-started', (route) => false);
        } else if (value == 1) {
          context.read<AuthCubit>().getCurrentUser(user.uid);
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else if (value == 2) {
          context.read<AuthCubit>().getCurrentUserPenyedia(user.uid);
          Navigator.pushNamedAndRemoveUntil(
              context, '/home_penyedia', (route) => false);
        } else if (value == 3) {
          context.read<AuthCubit>().getCurrentUserAdmin(user.uid);
          Navigator.pushNamedAndRemoveUntil(
              context, '/admin', (route) => false);
        }
      });
    });
    super.initState();
  }

  ///untuk penyimpanan value login page
  Future getvalidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainvalue = sharedPreferences.getInt('value');
    setState(() {
      value = obtainvalue;
    });
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LetsWash',
              style: whiteTextStyle.copyWith(
                fontSize: 32,
                fontWeight: medium,
                letterSpacing: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
