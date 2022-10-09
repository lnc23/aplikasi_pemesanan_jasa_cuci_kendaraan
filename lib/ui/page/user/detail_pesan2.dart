// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_element, empty_statements, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:here_sdk/core.dart';
import 'package:intl/intl.dart';
import 'package:lazywash/cubit/auth_cubit.dart';
import 'package:lazywash/models/harga_model.dart';
import 'package:lazywash/services/SearchExample.dart';
import 'package:lazywash/services/storage_service.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/user/detail_pesan1.dart';
import 'package:lazywash/ui/page/user/home_page.dart';
import 'package:lazywash/ui/page/user/pembayaran.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:lazywash/ui/page/widgets/custom_button_back.dart';
import 'package:lazywash/ui/page/widgets/custom_form_detail.dart';
import 'package:lazywash/ui/page/widgets/custom_text_form_field.dart';
import 'package:lazywash/ui/page/widgets/here_map.dart';
import 'package:lazywash/ui/page/widgets/location_service.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../cubit/auth_state.dart';

class DetailPesan2 extends StatefulWidget {
  DetailPesan2(
      {Key? key,
      this.jenis_kendaraan = '',
      this.jenis_cuci_kendaraan = '',
      this.alamat = ''})
      : super(key: key);

  final jenis_kendaraan;
  final jenis_cuci_kendaraan;
  final String alamat;

  @override
  State<DetailPesan2> createState() => _DetailPesan2State();
}

class _DetailPesan2State extends State<DetailPesan2> {
  final date = DateFormat.yMd().format(
    DateTime.now(),
  );

  MoneyFormatter fmf = MoneyFormatter(
      amount: 12345678.9012345,
      settings: MoneyFormatterSettings(
        symbol: 'IDR',
      ));

  double biaya_layanan = 0;

  double cuci_motor_biasa = 0;

  double cuci_motor_lengkap = 0;

  double cuci_mobil_biasa = 0;

  double cuci_mobil_lengkap = 0;

  double total_harga = 0;

  double distance = GeoCoordinates(LocationService.lat, LocationService.long)
      .distanceTo(GeoCoordinates(-6.2023355593854435, 106.73048961103426));

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference pesan = firestore.collection('pesanan');

    Widget back() {
      return Container(
          child: Row(
        children: [
          CustomButtonBack(onPressed: () {
            Navigator.pushNamed(context, '/detail_pesan1');
          }),
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
            ),
            child: Text(
              'Detail Pesanan',
              style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
            ),
          ),
        ],
      ));
    }

    Widget alamatrumah() {
      return CustomFormDetail(title: 'Alamat Rumah', isi: '${widget.alamat}');
    }

    Widget jeniskendaraan() {
      if (widget.jenis_kendaraan == RadioJenisKendaraan.motor) {
        return CustomFormDetail(title: 'Jenis Kendaraan', isi: 'Motor');
      } else {
        return CustomFormDetail(title: 'Jenis Kendaraan', isi: 'Mobil');
      }
    }

    Widget jeniscucikendaraan() {
      if (widget.jenis_cuci_kendaraan == RadioJenisCuci.cuci_kendaraan_biasa) {
        return CustomFormDetail(
            title: 'Jenis Cuci Kendaraan', isi: 'Cuci kendaraan biasa');
      } else {
        return CustomFormDetail(
            title: 'Jenis Cuci Kendaraan', isi: 'Cuci kendaraan lengkap');
      }
    }

    Widget harga() {
      return Container(
        child: FutureBuilder<HargaModel?>(
          future: readHarga(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (widget.jenis_cuci_kendaraan ==
                  RadioJenisCuci.cuci_kendaraan_biasa) {
                if (widget.jenis_kendaraan == RadioJenisKendaraan.motor) {
                  cuci_motor_biasa =
                      snapshot.data!.cuci_motor_biasa!.toDouble();
                  if (distance <= 500) {
                    biaya_layanan = snapshot.data!.jarak_500m!.toDouble();
                  } else if (distance <= 1000) {
                    biaya_layanan = snapshot.data!.jarak_1000m!.toDouble();
                  } else if (distance <= 1500) {
                    biaya_layanan = snapshot.data!.jarak_1500m!.toDouble();
                  } else if (distance <= 2000) {
                    biaya_layanan = snapshot.data!.jarak_2000m!.toDouble();
                  }
                  total_harga = cuci_motor_biasa + biaya_layanan;
                  return Container(
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
                                'Harga',
                                style: blackTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'Subtotal Pesanan',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14, fontWeight: light),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'Biaya Layanan',
                                  style: blackTextStyle,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'Total',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 15,
                                    fontWeight: bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 35,
                              ),
                              Text(
                                  fmf
                                      .copyWith(
                                          amount: cuci_motor_biasa,
                                          fractionDigits: 0)
                                      .output
                                      .symbolOnLeft,
                                  style: blackTextStyle),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  fmf
                                      .copyWith(
                                          amount: biaya_layanan,
                                          fractionDigits: 0)
                                      .output
                                      .symbolOnLeft,
                                  style: blackTextStyle),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                fmf
                                    .copyWith(
                                        amount: total_harga, fractionDigits: 0)
                                    .output
                                    .symbolOnLeft,
                                style: greenTextStyle.copyWith(
                                    fontSize: 15, fontWeight: bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  cuci_mobil_biasa =
                      snapshot.data!.cuci_mobil_biasa!.toDouble();
                  if (distance <= 500) {
                    biaya_layanan = snapshot.data!.jarak_500m!.toDouble();
                  } else if (distance <= 1000) {
                    biaya_layanan = snapshot.data!.jarak_1000m!.toDouble();
                  } else if (distance <= 1500) {
                    biaya_layanan = snapshot.data!.jarak_1500m!.toDouble();
                  } else if (distance <= 2000) {
                    biaya_layanan = snapshot.data!.jarak_2000m!.toDouble();
                  }
                  total_harga = cuci_mobil_biasa + biaya_layanan;
                  return Container(
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
                                'Harga',
                                style: blackTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'Subtotal Pesanan',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14, fontWeight: light),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'Biaya Layanan',
                                  style: blackTextStyle,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'Total',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 15,
                                    fontWeight: bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 35,
                              ),
                              Text(
                                  fmf
                                      .copyWith(
                                          amount: cuci_mobil_biasa,
                                          fractionDigits: 0)
                                      .output
                                      .symbolOnLeft,
                                  style: blackTextStyle),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  fmf
                                      .copyWith(
                                          amount: biaya_layanan,
                                          fractionDigits: 0)
                                      .output
                                      .symbolOnLeft,
                                  style: blackTextStyle),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                fmf
                                    .copyWith(
                                        amount: total_harga, fractionDigits: 0)
                                    .output
                                    .symbolOnLeft,
                                style: greenTextStyle.copyWith(
                                    fontSize: 15, fontWeight: bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              } else {
                if (widget.jenis_kendaraan == RadioJenisKendaraan.motor) {
                  cuci_motor_lengkap =
                      snapshot.data!.cuci_motor_lengkap!.toDouble();
                  if (distance <= 500) {
                    biaya_layanan = snapshot.data!.jarak_500m!.toDouble();
                  } else if (distance <= 1000) {
                    biaya_layanan = snapshot.data!.jarak_1000m!.toDouble();
                  } else if (distance <= 1500) {
                    biaya_layanan = snapshot.data!.jarak_1500m!.toDouble();
                  } else if (distance <= 2000) {
                    biaya_layanan = snapshot.data!.jarak_2000m!.toDouble();
                  }
                  total_harga = cuci_motor_lengkap + biaya_layanan;
                  return Container(
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
                                'Harga',
                                style: blackTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'Subtotal Pesanan',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14, fontWeight: light),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text('Biaya Layanan'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'Total',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 15,
                                    fontWeight: bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 35,
                              ),
                              Text(
                                  fmf
                                      .copyWith(
                                          amount: cuci_motor_lengkap,
                                          fractionDigits: 0)
                                      .output
                                      .symbolOnLeft,
                                  style: blackTextStyle),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  fmf
                                      .copyWith(
                                          amount: biaya_layanan,
                                          fractionDigits: 0)
                                      .output
                                      .symbolOnLeft,
                                  style: blackTextStyle),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                fmf
                                    .copyWith(
                                        amount: total_harga, fractionDigits: 0)
                                    .output
                                    .symbolOnLeft,
                                style: greenTextStyle.copyWith(
                                    fontSize: 15, fontWeight: bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  cuci_mobil_lengkap =
                      snapshot.data!.cuci_mobil_lengkap!.toDouble();
                  if (distance <= 500) {
                    biaya_layanan = snapshot.data!.jarak_500m!.toDouble();
                  } else if (distance <= 1000) {
                    biaya_layanan = snapshot.data!.jarak_1000m!.toDouble();
                  } else if (distance <= 1500) {
                    biaya_layanan = snapshot.data!.jarak_1500m!.toDouble();
                  } else if (distance <= 2000) {
                    biaya_layanan = snapshot.data!.jarak_2000m!.toDouble();
                  }
                  total_harga = cuci_mobil_lengkap + biaya_layanan;
                  return Container(
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
                                'Harga',
                                style: blackTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'Subtotal Pesanan',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14, fontWeight: light),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text('Biaya Layanan'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'Total',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 15,
                                    fontWeight: bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 35,
                              ),
                              Text(
                                  fmf
                                      .copyWith(
                                          amount: cuci_mobil_lengkap,
                                          fractionDigits: 0)
                                      .output
                                      .symbolOnLeft,
                                  style: blackTextStyle),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  fmf
                                      .copyWith(
                                          amount: biaya_layanan,
                                          fractionDigits: 0)
                                      .output
                                      .symbolOnLeft,
                                  style: blackTextStyle),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                fmf
                                    .copyWith(
                                        amount: total_harga, fractionDigits: 0)
                                    .output
                                    .symbolOnLeft,
                                style: greenTextStyle.copyWith(
                                    fontSize: 15, fontWeight: bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    }

    Widget pembayaran() {
      if (widget.jenis_cuci_kendaraan == RadioJenisCuci.cuci_kendaraan_biasa) {
        if (widget.jenis_kendaraan == RadioJenisKendaraan.motor) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return CustomButton(
                  title: 'Pesan',
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                    var name = state.user.name;
                    NotificationApi.showNotification(
                      title: "Halo $name",
                      body:
                          "Kamu berhasil melakukan pemesanan, segera melakukan konfirmasi pembayaran",
                      payload: "konfirmasi pembayaran",
                    );
                    int no_telp = int.parse(state.user.no_telp);
                    pesan.add(
                      {
                        'id_pemesan': state.user.id,
                        'id_penyedia': '',
                        'nama_pemesan': state.user.name,
                        'nama_penyedia_jasa': '',
                        'tgl': date,
                        'no_telp': no_telp,
                        'jenis_kendaraan': 'Motor',
                        'jenis_cuci_kendaraan': 'Cuci kendaraan biasa',
                        'alamat': widget.alamat,
                        'latitude': SearchExample.lat,
                        'longitude': SearchExample.lat,
                        'harga': '$total_harga',
                        'status': 'Pesanan Belum Diterima'
                      },
                    );
                  },
                );
              } else {
                return SizedBox();
              }
            },
          );
        } else {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return CustomButton(
                  title: 'Pesan',
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                    var name = state.user.name;
                    NotificationApi.showNotification(
                      title: "Halo $name",
                      body:
                          "Kamu berhasil melakukan pemesanan, segera melakukan konfirmasi pembayaran",
                      payload: "konfirmasi pembayaran",
                    );
                    int no_telp = int.parse(state.user.no_telp);
                    pesan.add(
                      {
                        'id_pemesan': state.user.id,
                        'id_penyedia': '',
                        'nama_pemesan': state.user.name,
                        'nama_penyedia_jasa': '',
                        'tgl': date,
                        'no_telp': no_telp,
                        'jenis_kendaraan': 'Mobil',
                        'jenis_cuci_kendaraan': 'Cuci kendaraan biasa',
                        'alamat': widget.alamat,
                        'latitude': SearchExample.lat,
                        'longitude': SearchExample.long,
                        'harga': '$total_harga',
                        'status': 'Pesanan Belum Diterima'
                      },
                    );
                  },
                );
              } else {
                return SizedBox();
              }
            },
          );
        }
      } else {
        if (widget.jenis_kendaraan == RadioJenisKendaraan.motor) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return CustomButton(
                    title: 'Pesan',
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                      int no_telp = int.parse(state.user.no_telp);
                      var name = state.user.name;
                      NotificationApi.showNotification(
                        title: "Halo $name",
                        body:
                            "Kamu berhasil melakukan pemesanan, segera melakukan konfirmasi pembayaran",
                        payload: "konfirmasi pembayaran",
                      );
                      pesan.add(
                        {
                          'id_pemesan': state.user.id,
                          'id_penyedia': '',
                          'nama_pemesan': state.user.name,
                          'nama_penyedia_jasa': '',
                          'tgl': date,
                          'no_telp': no_telp,
                          'jenis_kendaraan': 'Motor',
                          'jenis_cuci_kendaraan': 'Cuci kendaraan lengkap',
                          'alamat': widget.alamat,
                          'latitude': SearchExample.lat,
                          'longitude': SearchExample.long,
                          'harga': '$total_harga',
                          'status': 'Pesanan Belum Diterima'
                        },
                      );
                    });
              } else {
                return SizedBox();
              }
            },
          );
        } else {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return CustomButton(
                    title: 'Pesan',
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                      int no_telp = int.parse(state.user.no_telp);
                      var name = state.user.name;
                      NotificationApi.showNotification(
                        title: "Halo $name",
                        body:
                            "Kamu berhasil melakukan pemesanan, segera melakukan konfirmasi pembayaran",
                        payload: "konfirmasi pembayaran",
                      );
                      pesan.add(
                        {
                          'id_pemesan': state.user.id,
                          'id_penyedia': '',
                          'nama_pemesan': state.user.name,
                          'nama_penyedia_jasa': '',
                          'tgl': date,
                          'no_telp': no_telp,
                          'jenis_kendaraan': 'Mobil',
                          'jenis_cuci_kendaraan': 'Cuci kendaraan lengkap',
                          'alamat': widget.alamat,
                          'latitude': SearchExample.lat,
                          'longitude': SearchExample.long,
                          'harga': '$total_harga',
                          'status': 'Pesanan Belum Diterima'
                        },
                      );
                    });
              } else {
                return SizedBox();
              }
            },
          );
        }
      }
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
                height: 15,
              ),
              alamatrumah(),
              jeniskendaraan(),
              jeniscucikendaraan(),
              harga(),
              SizedBox(
                height: 45,
              ),
              pembayaran()
            ]),
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

Future _notificationDetails() async {
  return NotificationDetails(
    android: AndroidNotificationDetails(
      'channelId',
      'channelName',
      'channelDescription',
      importance: Importance.max,
      icon: "notification",
    ),
    //iOS: IOSNotificationDetails(),
  );
}

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);
}
