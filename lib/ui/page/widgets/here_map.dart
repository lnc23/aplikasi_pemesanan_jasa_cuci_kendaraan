// ignore_for_file: unused_field, prefer_const_constructors, duplicate_ignore, unnecessary_new

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:here_sdk/mapview.dart';
import 'package:lazywash/services/SearchExample.dart';
import 'package:lazywash/ui/page/widgets/location_service.dart';
import 'package:lazywash/ui/page/widgets/user_location.dart';

class LocationApp extends StatefulWidget {
  const LocationApp({Key? key}) : super(key: key);

  @override
  State<LocationApp> createState() => hereMap();
}

class hereMap extends State<LocationApp> {
  LocationService locationService = LocationService();
  late HereMapController _controller;
  SearchExample? _searchExample;

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<UserLocation>(
        stream: locationService.locationStream,
        builder: (_, snapshot) => (snapshot.hasData)
            ? Center(
                child: HereMap(
                  onMapCreated: onMapCreated,
                ),
              )
            : SizedBox(),
      ),
    );
  }

  void onMapCreated(HereMapController hereMapController) {
    _controller = hereMapController;
    hereMapController.mapScene.loadSceneForMapScheme(
      MapScheme.normalDay,
      (error) {
        if (error == null) {
          _searchExample = SearchExample(_showDialog, hereMapController);
        } else {
          print("Map scene not loaded. MapError: " + error.toString());
        }
      },
    );
  }

  Future<void> _showDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
