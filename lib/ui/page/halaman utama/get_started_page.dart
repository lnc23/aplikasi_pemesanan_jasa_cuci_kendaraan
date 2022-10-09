// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/widgets/custom_button.dart';
import 'package:lazywash/ui/page/widgets/location_service.dart';

class GetStartedPage extends StatefulWidget {
  GetStartedPage ({ Key? key }) : super(key: key);

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  LocationService locationService = LocationService();

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                'assets/img_get_started_page.png'
                ),
                fit: BoxFit.cover
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment:  MainAxisAlignment.end,
              children: [
                Text(
                  'Wash Your Vehicle',
                  style: whiteTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: semibold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Use our service to wash \nyour favorite vehicle',
                  style: whiteTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: light,
                  ),
                  textAlign: TextAlign.center,
                ),
                CustomButton(
                  title: 'Masuk',
                  width: 220,
                  margin: EdgeInsets.only(top: 55, bottom: 60),
                  onPressed: (){
                    Navigator.pushNamed(context, '/sign_in');
                  },
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
          
        ],
      )
    );
  }
}