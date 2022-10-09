// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazywash/cubit/auth_cubit.dart';
import 'package:lazywash/models/pesanan_model.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:lazywash/ui/page/widgets/custom_button_back.dart';
import 'package:lazywash/ui/page/widgets/custom_form_detail.dart';
import 'package:lazywash/ui/page/widgets/here_map_point.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../cubit/auth_state.dart';

class DetailHistoryPenyedia extends StatelessWidget {
  final PesananModel pesanan;
  const DetailHistoryPenyedia(this.pesanan, {Key? key}) : super(key: key);

  static double pesanlat = 0;
  static double pesanlong = 0;

  @override
  Widget build(BuildContext context) {
    pesanlat = pesanan.latitude!;
    pesanlong = pesanan.longitude!;

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Row(
          children: [
            CustomButtonBack(onPressed: () {
              Navigator.pushNamed(context, '/home_penyedia');
            }),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                'Detail Pemesanan',
                style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
              ),
            ),
          ],
        ),
      );
    }

    Widget status() {
      return CustomFormDetail(
        title: 'Status Pemesanan',
        isi: pesanan.status.toString(),
      );
    }

    Widget heremap() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
        ),
        child: Container(
          width: 320,
          height: 320,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: HereMapPoint(),
          ),
        ),
      );
    }

    Widget buttonroute() {
      return CustomButton(
        title: 'Detail Rute',
        onPressed: () {
          Navigator.pushNamed(context, '/detail_route');
        },
      );
    }

    Widget idpesanan() {
      return CustomFormDetail(
        title: "ID Pesanan",
        isi: pesanan.id.toString(),
      );
    }

    Widget jeniskendaraan() {
      return CustomFormDetail(
        title: 'Jenis Kendaraan',
        isi: pesanan.jenis_kendaraan.toString(),
      );
    }

    Widget namapemesan() {
      return CustomFormDetail(
        title: 'Nama Pemesan',
        isi: pesanan.nama_pemesan.toString(),
      );
    }

    Widget jeniscucikendaraan() {
      return CustomFormDetail(
        title: 'Jenis Cuci Kendaraan',
        isi: pesanan.jenis_cuci_kendaraan.toString(),
      );
    }

    Widget alamat() {
      return CustomFormDetail(
        title: 'Alamat',
        isi: pesanan.alamat.toString(),
      );
    }

    Widget buttonTerima() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccessPenyedia) {
            return CustomButton(
              title: 'Terima Pesanan',
              onPressed: () {
                DocumentReference documentReference = FirebaseFirestore.instance
                    .collection("pesanan")
                    .doc(pesanan.id);
                documentReference.update(
                  {
                    'id_penyedia': state.userpenyedia.id,
                    'status': 'Proses',
                    'no_telp_penyedia': int.parse(state.userpenyedia.no_telp),
                    'nama_penyedia_jasa': state.userpenyedia.name
                  },
                );
                Navigator.pushNamed(context, '/home_penyedia');
              },
            );
          } else {
            return SizedBox();
          }
        },
      );
    }

    Widget batal() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccessPenyedia) {
            return CustomButton(
              title: 'Cancel Pesanan',
              onPressed: () {
                var status = 'Batal';
                DocumentReference documentReference = FirebaseFirestore.instance
                    .collection("pesanan")
                    .doc(pesanan.id);
                documentReference.update(
                  {
                    'status': status,
                  },
                );
                Navigator.pushNamed(context, '/home_penyedia');
              },
            );
          } else {
            return SizedBox();
          }
        },
      );
    }

    Widget buttonWhatsapp() {
      int? noTelp = pesanan.no_telp;
      return CustomButton(
        title: 'Chat Dengan Pemesan',
        onPressed: () async => await launch("https://wa.me/+62$noTelp?text="),
      );
    }

    Widget buttonkirimidpenyedia() {
      String? idpenyedia = pesanan.id_penyedia;
      String? nama = pesanan.nama_penyedia_jasa;
      int? noTelp = pesanan.no_telp;
      return CustomButton(
        title: 'Chat Dengan Pemesan',
        onPressed: () async => await launch(
            "https://wa.me/+62$noTelp?text=id penyedia = $idpenyedia, atas nama = $nama"),
      );
    }

    if (pesanan.id_penyedia == "") {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: SafeArea(
            child: ListView(
              children: [
                header(),
                heremap(),
                idpesanan(),
                namapemesan(),
                status(),
                jeniskendaraan(),
                jeniscucikendaraan(),
                alamat(),
                SizedBox(
                  height: 15,
                ),
                buttonTerima(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    } else if (pesanan.status == "Proses") {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: SafeArea(
            child: ListView(
              children: [
                header(),
                heremap(),
                buttonroute(),
                idpesanan(),
                namapemesan(),
                status(),
                jeniskendaraan(),
                jeniscucikendaraan(),
                alamat(),
                SizedBox(
                  height: 15,
                ),
                buttonWhatsapp(),
                buttonkirimidpenyedia(),
                SizedBox(
                  height: 5,
                ),
                batal(),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: SafeArea(
            child: ListView(
              children: [
                header(),
                heremap(),
                idpesanan(),
                namapemesan(),
                status(),
                jeniskendaraan(),
                jeniscucikendaraan(),
                alamat(),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
