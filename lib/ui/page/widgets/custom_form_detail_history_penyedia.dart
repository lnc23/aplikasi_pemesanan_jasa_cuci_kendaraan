// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:lazywash/models/pesanan_model.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/penyedia/detail_history_penyedia.dart';
import 'package:lazywash/ui/page/user/detail_pesan2.dart';
import 'package:lazywash/ui/page/widgets/location_service.dart';

class CustomFormDetailHistoryPenyedia extends StatefulWidget {
  final PesananModel pesanan;

  const CustomFormDetailHistoryPenyedia(
    this.pesanan, {
    Key? key,
  }) : super(key: key);

  @override
  State<CustomFormDetailHistoryPenyedia> createState() =>
      _CustomFormDetailHistoryPenyediaState();
}

class _CustomFormDetailHistoryPenyediaState
    extends State<CustomFormDetailHistoryPenyedia> {
  LocationService locationService = LocationService();
  static double latitude = 0;
  static double longitude = 0;
  static double latpesan = 0;
  static double longpesan = 0;
  static double distance = 0;
  @override
  void initState() {
    super.initState();
    locationService.locationStream.listen(
      (userLocation) {
        setState(
          () {
            latitude = userLocation.latitude;
            longitude = userLocation.longitude;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    latpesan = widget.pesanan.latitude!;
    longpesan = widget.pesanan.longitude!;
    distance = GeoCoordinates(latitude, longitude).distanceTo(
      GeoCoordinates(latpesan, longpesan),
    );
    if (distance <= 2000) {
      if (widget.pesanan.id_penyedia == "") {
        String name = widget.pesanan.nama_pemesan.toString();
        NotificationApi.showNotification(
          title: "Pesanan baru dari $name",
          body: "Kamu mendapatkan pesanan baru",
          payload: "pesanan baru",
        );
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailHistoryPenyedia(widget.pesanan),
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
                        widget.pesanan.tgl.toString(),
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.pesanan.nama_pemesan.toString(),
                        style: blackTextStyle.copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.pesanan.jenis_kendaraan.toString(),
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
                        widget.pesanan.jenis_cuci_kendaraan.toString(),
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
                          widget.pesanan.status.toString(),
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
      } else if (widget.pesanan.status == "Proses") {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailHistoryPenyedia(widget.pesanan),
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
                        widget.pesanan.tgl.toString(),
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.pesanan.nama_pemesan.toString(),
                        style: blackTextStyle.copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.pesanan.jenis_kendaraan.toString(),
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
                        widget.pesanan.jenis_cuci_kendaraan.toString(),
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
                          widget.pesanan.status.toString(),
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
      } else {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailHistoryPenyedia(widget.pesanan),
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
                        widget.pesanan.tgl.toString(),
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.pesanan.nama_pemesan.toString(),
                        style: blackTextStyle.copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.pesanan.jenis_kendaraan.toString(),
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
                        widget.pesanan.jenis_cuci_kendaraan.toString(),
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
                          widget.pesanan.status.toString(),
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
    } else {
      return SizedBox();
    }
  }
}
