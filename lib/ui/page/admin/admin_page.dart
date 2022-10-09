// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazywash/cubit/auth_cubit.dart';
import 'package:lazywash/cubit/auth_state.dart';
import 'package:lazywash/cubit/harga_cubit.dart';
import 'package:lazywash/models/harga_model.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/admin/admin_ubah_harga.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:lazywash/ui/page/widgets/custom_form_detail_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccessAdmin) {
            return Container(
              margin: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
                top: 30,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Anda Login Sebagai, \n${state.useradmin.name}',
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
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      );
    }

    Widget verifikasi_pesanan() {
      return Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: CustomButton(
            title: "Verifikasi Pesanan",
            onPressed: () {
              Navigator.pushNamed(context, '/admin_verifikasi_pesanan');
            }),
      );
    }

    Widget daftar_penyedia() {
      return Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: CustomButton(
          title: "Daftar Penyedia Jasa",
          onPressed: () {
            Navigator.pushNamed(context, '/admin_daftar_penyedia_jasa');
          },
        ),
      );
    }

    Widget ubah_harga() {
      return Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: CustomButton(
          title: "Ubah Harga",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminUbahHarga(),
              ),
            );
          },
        ),
      );
    }

    Widget signout() {
      return Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: CustomButton(
          title: 'Sign Out',
          onPressed: () async {
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.remove("value");
            context.read<AuthCubit>().signOut();
            Navigator.pushNamed(context, '/sign_in');
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: ListView(
        children: [
          header(),
          SizedBox(
            height: 80,
          ),
          verifikasi_pesanan(),
          SizedBox(
            height: 30,
          ),
          daftar_penyedia(),
          SizedBox(
            height: 30,
          ),
          ubah_harga(),
          SizedBox(
            height: 30,
          ),
          signout(),
        ],
      )),
    );
  }
}
