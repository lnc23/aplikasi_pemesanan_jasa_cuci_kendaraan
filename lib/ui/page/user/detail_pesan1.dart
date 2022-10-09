// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_element, empty_statements

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazywash/cubit/auth_cubit.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/user/detail_pesan2.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:lazywash/ui/page/widgets/custom_button_back.dart';
import 'package:lazywash/ui/page/widgets/custom_text_form_field.dart';

import '../../../cubit/auth_state.dart';

class DetailPesan1 extends StatelessWidget {
  DetailPesan1({
    Key? key,
  }) : super(key: key);

  TextEditingController jeniskendaraanController =
      TextEditingController(text: '');
  TextEditingController patokanrumahController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Widget back() {
      return Container(
        child: Row(
          children: [
            CustomButtonBack(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
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

    Widget jeniskendaraan() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis kendaraan',
              style: blackTextStyle,
            ),
            SizedBox(
              height: 5,
            ),
            JenisKendaraan()
          ],
        ),
      );
    }

    Widget jeniscucikendaraan() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis cuci kendaraan',
              style: blackTextStyle,
            ),
            SizedBox(
              height: 5,
            ),
            RadioJenisCuciKendaraan()
          ],
        ),
      );
    }

    Widget alamatrumah() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            patokanrumahController.text = state.user.alamat;
            return CustomTextFormField(
              title: 'Alamat Rumah',
              hinText: state.user.alamat,
              controller: patokanrumahController,
            );
          } else {
            return CustomTextFormField(
              title: 'Alamat Rumah',
              hinText: 'Alamat & patokan rumah',
              controller: patokanrumahController,
            );
          }
        },
      );
    }

    Widget next() {
      return CustomButton(
          title: 'Selanjutnya',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailPesan2(
                  jenis_kendaraan: _RadioJenisKendaraanState._character,
                  jenis_cuci_kendaraan:
                      _RadioJenisCuciKendaraanState._character,
                  alamat: patokanrumahController.text,
                ),
              ),
            );
          });
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
              height: 30,
            ),
            jeniskendaraan(),
            SizedBox(
              height: 20,
            ),
            jeniscucikendaraan(),
            SizedBox(
              height: 20,
            ),
            alamatrumah(),
            Text(
              "Note :\n\n-Cuci Kendaraan Biasa\nmotor / mobil hanya cuci kendaraan menggunakan shampo khusus\n\n-Cuci Kendaraan Lengkap:\nuntuk body motor akan di wax dan ban disemir\nuntuk mobil akan di wax dan di semir, bagian dalam mobil akan di bersihkan secara menyeluruh",
              style: blackTextStyle.copyWith(
                fontSize: 10,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            next(),
          ],
        ),
      ),
    );
  }
}

enum RadioJenisCuci { cuci_kendaraan_biasa, cuci_kendaraan_lengkap }

class RadioJenisCuciKendaraan extends StatefulWidget {
  const RadioJenisCuciKendaraan({Key? key}) : super(key: key);

  @override
  State<RadioJenisCuciKendaraan> createState() =>
      _RadioJenisCuciKendaraanState();
}

enum RadioJenisKendaraan { motor, mobil }

class JenisKendaraan extends StatefulWidget {
  const JenisKendaraan({Key? key}) : super(key: key);

  @override
  State<JenisKendaraan> createState() => _RadioJenisKendaraanState();
}

class _RadioJenisKendaraanState extends State<JenisKendaraan> {
  static RadioJenisKendaraan? _character = RadioJenisKendaraan.motor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Motor',
            style: blackTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
          leading: Radio<RadioJenisKendaraan>(
            value: RadioJenisKendaraan.motor,
            groupValue: _character,
            onChanged: (RadioJenisKendaraan? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: Text(
            'Mobil',
            style: blackTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
          leading: Radio<RadioJenisKendaraan>(
            value: RadioJenisKendaraan.mobil,
            groupValue: _character,
            onChanged: (RadioJenisKendaraan? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

class _RadioJenisCuciKendaraanState extends State<RadioJenisCuciKendaraan> {
  static RadioJenisCuci? _character = RadioJenisCuci.cuci_kendaraan_biasa;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Cuci kendaraan biasa',
            style: blackTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
          leading: Radio<RadioJenisCuci>(
            value: RadioJenisCuci.cuci_kendaraan_biasa,
            groupValue: _character,
            onChanged: (RadioJenisCuci? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: Text(
            'Cuci kendaraan lengkap',
            style: blackTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
          leading: Radio<RadioJenisCuci>(
            value: RadioJenisCuci.cuci_kendaraan_lengkap,
            groupValue: _character,
            onChanged: (RadioJenisCuci? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
