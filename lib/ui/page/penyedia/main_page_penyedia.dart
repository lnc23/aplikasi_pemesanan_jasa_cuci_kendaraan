// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazywash/cubit/page_cubit.dart';
import 'package:lazywash/ui/page/penyedia/home_penyedia_page.dart';
import 'package:lazywash/ui/page/penyedia/profile_penyedia_page.dart';
import 'package:lazywash/ui/page/widgets/custom_bottom_navigation_item.dart';
import '../../../shared/theme.dart';

class MainPagePenyedia extends StatefulWidget {
  const MainPagePenyedia({Key? key}) : super(key: key);

  @override
  State<MainPagePenyedia> createState() => _MainPagePenyediaState();
}

class _MainPagePenyediaState extends State<MainPagePenyedia> {
  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return HomePagePenyedia();
        case 1:
          return ProfilePagePenyedia();
        default:
          return HomePagePenyedia();
      }
    }

    Widget CustomButtomNavigation() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 200,
          height: 60,
          margin: EdgeInsets.only(
            bottom: 30,
            left: defaultMargin,
            right: defaultMargin,
          ),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomBottomNavigationItem(
                index: 0,
                imageUrl: 'assets/ic_history.png',
              ),
              CustomBottomNavigationItem(
                index: 1,
                imageUrl: 'assets/ic_setting.png',
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: Stack(
            children: [
              buildContent(currentIndex),
              CustomButtomNavigation(),
            ],
          ),
        );
      },
    );
  }
}
