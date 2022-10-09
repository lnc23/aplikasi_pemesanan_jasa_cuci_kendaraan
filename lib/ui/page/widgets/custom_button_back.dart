// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:lazywash/shared/theme.dart';

class CustomButtonBack extends StatelessWidget {

  final Function() onPressed;

  const CustomButtonBack({ 
    Key? key, 
    required this.onPressed, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
          onPressed: onPressed,
          icon: Image.asset('assets/ic_back.png'),
          iconSize: 30,
        ),
    );
  }
}