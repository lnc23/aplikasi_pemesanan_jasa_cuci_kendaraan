// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lazywash/shared/theme.dart';

class CustomFormDetail extends StatelessWidget {
  final String title;
  final String isi;

  const CustomFormDetail({Key? key, required this.title, required this.isi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: blackTextStyle.copyWith(
            fontWeight: bold,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          isi,
          style: blackTextStyle.copyWith(
            fontSize: 14,
            fontWeight: light,
          ),
        ),
      ]),
    );
  }
}
