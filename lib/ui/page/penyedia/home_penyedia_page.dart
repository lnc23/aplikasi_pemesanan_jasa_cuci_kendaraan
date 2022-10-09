// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lazywash/cubit/pesanan_cubit.dart';
import 'package:lazywash/models/pesanan_model.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/main.dart';
import 'package:lazywash/ui/page/widgets/custom_form_detail_history_penyedia.dart';

class HomePagePenyedia extends StatefulWidget {
  const HomePagePenyedia({Key? key}) : super(key: key);

  @override
  State<HomePagePenyedia> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HomePagePenyedia> {
  get flutterLocalNotificationsPlugin => null;

  @override
  void initState() {
    context.read<PesananCubit>().fetchPesanan();
    super.initState();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification notification = message.notification!;
        AndroidNotification android = message.notification!.android!;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: kBlueColor,
                playSound: true,
              ),
            ),
          );
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        print('A new onMessageOpenedApp event was publishd!');
        RemoteNotification notification = message.notification!;
        AndroidNotification android = message.notification!.android!;
        if (notification != null && android != null) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body!),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
              ),
              child: Text(
                'History',
                style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
              ),
            ),
          ],
        ),
      );
    }

    Widget detailhistory(List<PesananModel> pesanan) {
      return Container(
        child: Column(
          children: pesanan.map(
            (PesananModel pesanan) {
              return CustomFormDetailHistoryPenyedia(pesanan);
            },
          ).toList(),
        ),
      );
    }

    return BlocConsumer<PesananCubit, PesananState>(
      listener: (context, state) {
        if (state is PesananFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: kRedColor,
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is PesananSuccess) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Scaffold(
              backgroundColor: kBackgroundColor,
              body: SafeArea(
                child: ListView(
                  padding: EdgeInsets.only(
                      left: defaultMargin, right: defaultMargin, top: 35),
                  children: [
                    title(),
                    SizedBox(
                      height: 15,
                    ),
                    detailhistory(state.pesanan),
                  ],
                ),
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
