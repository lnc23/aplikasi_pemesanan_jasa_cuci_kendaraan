// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lazywash/models/pesanan_model.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/user/konfirmasi_penyedia.dart';
import 'package:lazywash/ui/page/user/pembayaran.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:lazywash/ui/page/widgets/custom_button_back.dart';
import 'package:lazywash/ui/page/widgets/custom_form_detail.dart';
import 'package:lazywash/ui/page/widgets/here_map.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailHistory extends StatelessWidget {
  final PesananModel pesanan;
  DetailHistory(this.pesanan, {Key? key}) : super(key: key);

  MoneyFormatter fmf = MoneyFormatter(
      amount: 12345678.9012345,
      settings: MoneyFormatterSettings(
        symbol: 'IDR',
      ));
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Row(
          children: [
            CustomButtonBack(onPressed: () {
              Navigator.pushNamed(context, '/home');
            }),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                'Pemesanan',
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

    Widget googlemap() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
        ),
        child: Container(
          width: 300,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: LocationApp(),
          ),
        ),
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
        isi: fmf
            .copyWith(amount: double.parse(pesanan.harga!), fractionDigits: 0)
            .output
            .symbolOnLeft,
      );
    }

    Widget buttonSelesai() {
      return CustomButton(
        title: 'Selesai',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PembayaranPage(
                total_harga: pesanan.harga,
              ),
            ),
          );
          DocumentReference documentReference =
              FirebaseFirestore.instance.collection("pesanan").doc(pesanan.id);
          var status = 'Verifikasi Pembayaran';
          documentReference.update(
            {
              'status': status,
            },
          );
        },
      );
    }

    Widget buttonKembali() {
      return CustomButton(
        title: "kembali",
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
      );
    }

    Widget buttonkonfirmasipembayaran() {
      var idpesanan = pesanan.id;
      var namapemesan = pesanan.nama_pemesan;
      return CustomButton(
        title: 'Konfirmasi Pembayaran',
        onPressed: () async => await launch(
            "https://wa.me/+62081384004840?text=Hallo,\nsaya ingin melakukan konfirmasi pembayaran untuk id pesanan '$idpesanan'\natas nama '$namapemesan'"),
      );
    }

    Widget buttonkonfirmasibatal() {
      return CustomButton(
        title: "Chat Admin",
        onPressed: () async =>
            await launch("https://wa.me/+62081384004840?text="),
      );
    }

    Widget buttonchatpenyedia() {
      int chatpenyedia = pesanan.no_telp_penyedia!;
      var idpesanan = pesanan.id;
      var namapemesan = pesanan.nama_pemesan;
      return CustomButton(
        title: 'Konfirmasi Pembayaran',
        onPressed: () async => await launch(
            "https://wa.me/+62$chatpenyedia?text=Hallo,\n Saya '$namapemesan' dengan id pesanan'$idpesanan' "),
      );
    }

    if (pesanan.status == 'Proses') {
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
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "estimasi penjemputan dan pencucian\n01:30:00",
                    style: blackTextStyle.copyWith(fontSize: 15),
                  ),
                ),
                idpesanan(),
                status(),
                jeniskendaraan(),
                jeniscucikendaraan(),
                alamat(),
                harga(),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  title: "Konfirmasi Penyedia",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => konfirmasiPenyedia(
                          id_penyedia: pesanan.id_penyedia,
                          nama_penyedia_jasa: pesanan.nama_penyedia_jasa,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                buttonSelesai(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    } else if (pesanan.status == "Verifikasi Pembayaran") {
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
                status(),
                jeniskendaraan(),
                jeniscucikendaraan(),
                alamat(),
                harga(),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    } else if (pesanan.status == "Batal") {
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
                status(),
                jeniskendaraan(),
                jeniscucikendaraan(),
                alamat(),
                SizedBox(
                  height: 10,
                ),
                buttonkonfirmasibatal(),
                SizedBox(
                  height: 5,
                ),
                buttonKembali(),
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
                status(),
                jeniskendaraan(),
                jeniscucikendaraan(),
                alamat(),
                SizedBox(
                  height: 5,
                ),
                buttonKembali(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
