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
import 'package:url_launcher/url_launcher.dart';

import '../../../cubit/auth_state.dart';

class DetailAdminVerifikasiPesanan extends StatelessWidget {
  final PesananModel pesanan;
  const DetailAdminVerifikasiPesanan(this.pesanan, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Row(
          children: [
            CustomButtonBack(
              onPressed: () {
                Navigator.pushNamed(context, '/admin_verifikasi_pesanan');
              },
            ),
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

    Widget namapemesan() {
      return CustomFormDetail(
        title: 'Nama Pemesan',
        isi: pesanan.nama_pemesan.toString(),
      );
    }

    Widget namapenyedia() {
      return CustomFormDetail(
        title: 'nama penyedia',
        isi: pesanan.nama_penyedia_jasa.toString(),
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

    Widget harga() {
      return CustomFormDetail(
        title: 'Harga',
        isi: pesanan.harga.toString(),
      );
    }

    Widget buttonTerima() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccessAdmin) {
            return CustomButton(
              title: 'Verifikasi Pembayaran',
              onPressed: () {
                DocumentReference documentReference = FirebaseFirestore.instance
                    .collection("pesanan")
                    .doc(pesanan.id);
                documentReference.update(
                  {
                    'status': 'Selesai',
                  },
                );
                Navigator.pushNamed(context, '/admin_verifikasi_pesanan');
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
        onPressed: () async =>
            await launch("https://wa.me/+62$noTelp?text=Hello"),
      );
    }

    if (pesanan.status == "Verifikasi Pembayaran") {
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
                idpesanan(),
                namapemesan(),
                namapenyedia(),
                status(),
                jeniskendaraan(),
                jeniscucikendaraan(),
                alamat(),
                harga(),
                SizedBox(
                  height: 5,
                ),
                buttonTerima(),
                SizedBox(
                  height: 5,
                ),
                buttonWhatsapp(),
                SizedBox(
                  height: 20,
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
                idpesanan(),
                namapemesan(),
                namapenyedia(),
                status(),
                jeniskendaraan(),
                jeniscucikendaraan(),
                alamat(),
                harga(),
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
