import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazywash/cubit/harga_cubit.dart';
import 'package:lazywash/models/harga_model.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:lazywash/ui/page/widgets/custom_text_form_field.dart';

class AdminUbahHarga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController motor_biasa = TextEditingController(text: '');
    final TextEditingController motor_lengkap = TextEditingController(text: '');
    final TextEditingController mobil_biasa = TextEditingController(text: '');
    final TextEditingController mobil_lengkap = TextEditingController(text: '');
    final TextEditingController j500m = TextEditingController(text: '');
    final TextEditingController j1000m = TextEditingController(text: '');
    final TextEditingController j1500m = TextEditingController(text: '');
    final TextEditingController j2000m = TextEditingController(text: '');

    Widget inputSection() {
      Widget cuci_motor_biasa() {
        return Container(
          child: FutureBuilder<HargaModel?>(
            future: readHarga(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                motor_biasa.text = snapshot.data!.cuci_motor_biasa.toString();
                return CustomTextFormField(
                    title: 'Harga Cuci Motor Biasa',
                    hinText: snapshot.data!.cuci_motor_biasa.toString(),
                    controller: motor_biasa);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      }

      Widget cuci_motor_lengkap() {
        return Container(
          child: FutureBuilder<HargaModel?>(
            future: readHarga(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                motor_lengkap.text =
                    snapshot.data!.cuci_motor_lengkap.toString();
                return CustomTextFormField(
                    title: 'Harga Cuci Motor Lengkap',
                    hinText: snapshot.data!.cuci_motor_lengkap.toString(),
                    controller: motor_lengkap);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      }

      Widget cuci_mobil_biasa() {
        return Container(
          child: FutureBuilder<HargaModel?>(
            future: readHarga(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                mobil_biasa.text = snapshot.data!.cuci_mobil_biasa.toString();
                return CustomTextFormField(
                    title: 'Harga Cuci Mobil Biasa',
                    hinText: snapshot.data!.cuci_mobil_biasa.toString(),
                    controller: mobil_biasa);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      }

      Widget cuci_mobil_lengkap() {
        return Container(
          child: FutureBuilder<HargaModel?>(
            future: readHarga(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                mobil_lengkap.text =
                    snapshot.data!.cuci_mobil_lengkap.toString();
                return CustomTextFormField(
                    title: 'Harga Cuci Mobil Lengkap',
                    hinText: snapshot.data!.cuci_mobil_lengkap.toString(),
                    controller: mobil_lengkap);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      }

      Widget jarak_500m() {
        return Container(
          child: FutureBuilder<HargaModel?>(
            future: readHarga(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                j500m.text = snapshot.data!.jarak_500m.toString();
                return CustomTextFormField(
                    title: 'Harga Jarak <=500',
                    hinText: snapshot.data!.jarak_500m.toString(),
                    controller: j500m);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      }

      Widget jarak_1000m() {
        return Container(
          child: FutureBuilder<HargaModel?>(
            future: readHarga(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                j1000m.text = snapshot.data!.jarak_1000m.toString();
                return CustomTextFormField(
                    title: 'Harga Jarak <=1000',
                    hinText: snapshot.data!.jarak_1000m.toString(),
                    controller: j1000m);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      }

      Widget jarak_1500m() {
        return Container(
          child: FutureBuilder<HargaModel?>(
            future: readHarga(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                j1500m.text = snapshot.data!.jarak_1500m.toString();
                return CustomTextFormField(
                    title: 'Harga Jarak <=1500',
                    hinText: snapshot.data!.jarak_1500m.toString(),
                    controller: j1500m);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      }

      Widget jarak_2000m() {
        return Container(
          child: FutureBuilder<HargaModel?>(
            future: readHarga(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                j2000m.text = snapshot.data!.jarak_2000m.toString();
                return CustomTextFormField(
                    title: 'Harga Jarak <=2000',
                    hinText: snapshot.data!.jarak_2000m.toString(),
                    controller: j2000m);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      }

      Widget button_save() {
        return CustomButton(
          title: "Simpan",
          onPressed: () {
            createHarga(
              cuci_motor_biasa: int.parse(motor_biasa.text),
              cuci_motor_lengkap: int.parse(motor_lengkap.text),
              cuci_mobil_biasa: int.parse(mobil_biasa.text),
              cuci_mobil_lengkap: int.parse(mobil_lengkap.text),
              jarak_500m: int.parse(j500m.text),
              jarak_1000m: int.parse(j1000m.text),
              jarak_1500m: int.parse(j1500m.text),
              jarak_2000m: int.parse(j2000m.text),
            );

            Navigator.pushNamed(context, '/admin');
          },
        );
      }

      return Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
        ),
        child: Column(
          children: [
            cuci_motor_biasa(),
            cuci_motor_lengkap(),
            cuci_mobil_biasa(),
            cuci_mobil_lengkap(),
            jarak_500m(),
            jarak_1000m(),
            jarak_1500m(),
            jarak_2000m(),
            button_save(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SafeArea(
          child: SizedBox(
            height: 1000,
            width: 500,
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Ubah Harga",
                    style: blackTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: bold,
                    ),
                  ),
                ),
                inputSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<HargaModel?> readHarga() async {
    final docHarga = FirebaseFirestore.instance
        .collection('harga')
        .doc('harga_cuci_kendaraan');
    final snapshot = await docHarga.get();

    if (snapshot.exists) {
      return HargaModel.fromJson(snapshot.data()!);
    }
  }

  Future createHarga(
      {required int cuci_motor_biasa,
      required int cuci_motor_lengkap,
      required int cuci_mobil_biasa,
      required int cuci_mobil_lengkap,
      required int jarak_500m,
      required int jarak_1000m,
      required int jarak_1500m,
      required int jarak_2000m}) async {
    final docHarga = FirebaseFirestore.instance
        .collection('harga')
        .doc('harga_cuci_kendaraan');

    final json = {
      'cuci_motor_biasa': cuci_motor_biasa,
      'cuci_motor_lengkap': cuci_motor_lengkap,
      'cuci_mobil_biasa': cuci_mobil_biasa,
      'cuci_mobil_lengkap': cuci_mobil_lengkap,
      'jarak_500m': jarak_500m,
      'jarak_1000m': jarak_1000m,
      'jarak_1500m': jarak_1500m,
      'jarak_2000m': jarak_2000m
    };

    await docHarga.set(json);
  }
}
