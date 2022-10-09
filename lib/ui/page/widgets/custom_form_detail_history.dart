// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazywash/cubit/auth_cubit.dart';
import 'package:lazywash/models/pesanan_model.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/user/detail_history.dart';

import '../../../cubit/auth_state.dart';

class CustomFormDetailHistory extends StatelessWidget {
  final PesananModel pesanan;

  const CustomFormDetailHistory(
    this.pesanan, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          if (pesanan.id_pemesan == state.user.id) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailHistory(pesanan),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(
                    defaultRadius,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pesanan.tgl.toString(),
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            pesanan.jenis_kendaraan.toString(),
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            pesanan.jenis_cuci_kendaraan.toString(),
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              pesanan.status.toString(),
                              style: blackTextStyle.copyWith(
                                  fontSize: 14, fontWeight: light),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        }
        return SizedBox();
      },
    );
  }
}
