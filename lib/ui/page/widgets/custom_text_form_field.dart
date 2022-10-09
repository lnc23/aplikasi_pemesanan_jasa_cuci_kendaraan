// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lazywash/shared/theme.dart';

class CustomTextFormField extends StatelessWidget {

  final String title;
  final String hinText;
  final bool obscureText;
  final TextEditingController controller;
  const CustomTextFormField({ Key? key, required this.title, required this.hinText, this.obscureText = false, required this.controller }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackTextStyle,
          ),
          SizedBox(
            height: 6,
          ),
          TextFormField(
            cursorColor: kBlackColor,
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              hintText: hinText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  defaultRadius,
                ), 
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  defaultRadius
                ),
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}