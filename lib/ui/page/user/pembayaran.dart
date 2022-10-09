// ignore_for_file: prefer_const_constructors, unused_element, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazywash/cubit/auth_cubit.dart';
import 'package:lazywash/cubit/auth_state.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:lazywash/ui/page/widgets/custom_button_back.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../models/pesanan_model.dart';

class PembayaranPage extends StatefulWidget {
  PembayaranPage({
    Key? key,
    this.total_harga = '',
  }) : super(key: key);

  final total_harga;

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  MoneyFormatter fmf = MoneyFormatter(
      amount: 12345678.9012345,
      settings: MoneyFormatterSettings(
        symbol: 'IDR',
      ));
  @override
  Widget build(BuildContext context) {
    Widget back() {
      return Container(
        child: Row(
          children: [
            CustomButtonBack(onPressed: () {
              Navigator.pushNamed(context, '/detail_pesan2');
            }),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
              ),
              child: Text(
                'Pembayaran',
                style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
              ),
            ),
          ],
        ),
      );
    }

    Widget listpembayaran() {
      double total_harga = double.parse(widget.total_harga);
      return Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 25,
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
                  Container(
                    width: 114,
                    height: 36,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img_bca.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 20,
                    ),
                    child: Text(
                      'Pembayaran Ke BCA',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 20,
                    ),
                    child: Text(
                      'No Rek. 7010401334',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      'Total',
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 135),
                  child: Text(
                    fmf
                        .copyWith(amount: total_harga, fractionDigits: 0)
                        .output
                        .symbolOnLeft,
                    style: greenTextStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget confirmpayment() {
      return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        if (state is AuthSuccess) {
          var namapemesan = state.user.name;
          return CustomButton(
            title: 'Konfirmasi Pembayaran',
            onPressed: () async => await launch(
              "https://wa.me/+62081384004840?text=Hallo,\nsaya ingin melakukan konfirmasi pembayaran atas nama $namapemesan",
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      });
    }

    Widget buttonHome() {
      return CustomButton(
        title: 'Kembali',
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
      );
    }

    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: ListView(
              padding: EdgeInsets.only(
                  left: defaultMargin, right: defaultMargin, top: 35),
              children: [
                back(),
                SizedBox(
                  height: 63,
                ),
                listpembayaran(),
                SizedBox(
                  height: 50,
                ),
                confirmpayment(),
                SizedBox(
                  height: 15,
                ),
                buttonHome(),
              ]),
        ));
  }
}
