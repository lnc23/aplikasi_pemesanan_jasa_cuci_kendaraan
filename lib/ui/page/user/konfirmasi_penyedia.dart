import 'package:flutter/material.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/user/detail_pesan2.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:lazywash/ui/page/widgets/custom_button_back.dart';
import 'package:lazywash/ui/page/widgets/custom_text_form_field.dart';

class konfirmasiPenyedia extends StatefulWidget {
  konfirmasiPenyedia({
    Key? key,
    this.id_penyedia,
    this.nama_penyedia_jasa,
  }) : super(key: key);

  final id_penyedia;
  final nama_penyedia_jasa;

  @override
  State<konfirmasiPenyedia> createState() => _konfirmasiPenyediaState();
}

class _konfirmasiPenyediaState extends State<konfirmasiPenyedia> {
  final TextEditingController idpenyediaController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Widget back() {
      return Container(
        child: Row(
          children: [
            CustomButtonBack(onPressed: () {
              Navigator.pushNamed(context, '/home');
            }),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  top: 30,
                ),
                child: Text(
                  'konfirmasi penyedia jasa cuci kendaraan',
                  style:
                      blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget textidpenyedia() {
      return CustomTextFormField(
        title: "Masukan ID Penyedia",
        hinText: "",
        controller: idpenyediaController,
      );
    }

    Widget buttonKonfirmasi() {
      String nama = widget.nama_penyedia_jasa;
      String idpenyedia = widget.id_penyedia;
      return CustomButton(
        title: "konfirmasi Penyedia",
        onPressed: () {
          print(idpenyedia);
          if (idpenyedia == idpenyediaController.text) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: kBlueColor,
                content: Text(
                  "penyedia jasa terknofirmasi atas nama $nama",
                  style: blackTextStyle.copyWith(fontSize: 18),
                ),
              ),
            );
            NotificationApi.showNotification(
              title: "penyedia jasa terkonfirmasi atas nama $nama",
              body:
                  "penyedia jasa terkonfirmasi atas nama $nama dengan id ${widget.id_penyedia}",
              payload: "penyedia jasa terkonfirmasi",
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: kBlueColor,
                content: Text(
                  "penyedia jasa bukan dari tempat cuci steam xyz",
                  style: blackTextStyle.copyWith(fontSize: 18),
                ),
              ),
            );
            NotificationApi.showNotification(
              title: "id tidak ada",
              body: "bukan karyawan dari penyedia jasa tempat cuci steam xyz",
              payload: "penyedia jasa terkonfirmasi",
            );
          }
        },
      );
    }

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
              back(),
              SizedBox(
                height: 30,
              ),
              textidpenyedia(),
              SizedBox(
                height: 30,
              ),
              buttonKonfirmasi(),
            ],
          ),
        ),
      ),
    );
  }
}
