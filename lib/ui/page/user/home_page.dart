// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:here_sdk/core.dart';
import 'package:lazywash/cubit/auth_cubit.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:lazywash/ui/page/widgets/here_map.dart';
import 'package:lazywash/ui/page/widgets/location_service.dart';
import '../../../cubit/auth_state.dart';
import '../../../services/storage_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Storage storage = Storage();
  var imageurl = "";
  LocationService locationService = LocationService();
  static double latitude = 0;
  static double longitude = 0;
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
    distance = GeoCoordinates(latitude, longitude)
        .distanceTo(GeoCoordinates(-6.2023355593854435, 106.73048961103426));

    Widget header() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            var imagename = state.user.id;
            return FutureBuilder(
              future: storage.downloadURL(imagename),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  imageurl = snapshot.data!;
                }
                return Container(
                  margin: EdgeInsets.only(
                    left: defaultMargin,
                    right: defaultMargin,
                    top: 30,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hallo, \n${state.user.name}',
                              style: blackTextStyle.copyWith(
                                fontSize: 24,
                                fontWeight: semibold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(imageurl),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return SizedBox();
          }
        },
      );
    }

    Widget header2() {
      return Container(
        margin: EdgeInsets.only(left: defaultMargin, top: 45),
        child: Row(
          children: [
            Text(
              'Lokasimu Saat Ini',
              style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
            ),
          ],
        ),
      );
    }

    Widget tidak_bisa_memesan() {
      return Container(
        margin:
            EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 15),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Jarak kamu lebih dari 2 KM, dari tempat cuci steam XYZ',
                style: blackTextStyle.copyWith(fontSize: 14, fontWeight: bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonpesan() {
      return CustomButton(
        margin: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
        title: 'Pesan Jasa Sekarang',
        onPressed: () {
          Navigator.pushNamed(context, '/detail_pesan1');
        },
      );
    }

    if (distance <= 2000) {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              header(),
              header2(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthSuccess) {
                      return Container(
                        width: 300,
                        height: 300,
                        child: LocationApp(),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              buttonpesan(),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              header(),
              header2(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthSuccess) {
                      return Container(
                        width: 300,
                        height: 300,
                        child: LocationApp(),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              tidak_bisa_memesan(),
            ],
          ),
        ),
      );
    }
  }
}
