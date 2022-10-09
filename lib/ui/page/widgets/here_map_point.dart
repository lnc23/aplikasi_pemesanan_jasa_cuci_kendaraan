import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:lazywash/ui/page/penyedia/detail_history_penyedia.dart';
import 'package:lazywash/ui/page/widgets/location_service.dart';
import 'package:lazywash/ui/page/widgets/user_location.dart';

class HereMapPoint extends StatefulWidget {
  const HereMapPoint({Key? key}) : super(key: key);

  @override
  State<HereMapPoint> createState() => _HereMapPointState();
}

class _HereMapPointState extends State<HereMapPoint> {
  late HereMapController _controller;
  late MapPolyline _mapPolyline;

  LocationService locationService = LocationService();

  @override
  void dispose() {
    locationService.dispose();
    _controller.finalize();
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

  Future<void> drawStartPoint(HereMapController hereMapController,
      int drawOrder, GeoCoordinates geoCoordinates) async {
    ByteData fileData = await rootBundle.load('assets/start_point.png');
    Uint8List pixelData = fileData.buffer.asUint8List();
    MapImage mapImage =
        MapImage.withPixelDataAndImageFormat(pixelData, ImageFormat.png);
    MapMarker mapMarker = MapMarker(geoCoordinates, mapImage);
    mapMarker.drawOrder = drawOrder;
    hereMapController.mapScene.addMapMarker(mapMarker);
  }

  Future<void> drawEndPoint(HereMapController hereMapController, int drawOrder,
      GeoCoordinates geoCoordinates) async {
    ByteData fileData = await rootBundle.load('assets/end_point.png');
    Uint8List pixelData = fileData.buffer.asUint8List();
    MapImage mapImage =
        MapImage.withPixelDataAndImageFormat(pixelData, ImageFormat.png);
    MapMarker mapMarker = MapMarker(geoCoordinates, mapImage);
    mapMarker.drawOrder = drawOrder;
    hereMapController.mapScene.addMapMarker(mapMarker);
  }

  void onMapCreated(HereMapController hereMapController) {
    _controller = hereMapController;
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (error) {
      if (error != null) {
        print('Error' + error.toString());
        return;
      }
    });

    drawStartPoint(
      hereMapController,
      0,
      GeoCoordinates(LocationService.lat, LocationService.long),
    );

    drawEndPoint(
      hereMapController,
      0,
      GeoCoordinates(
          DetailHistoryPenyedia.pesanlat, DetailHistoryPenyedia.pesanlong),
    );

    double distanceToEarthInMeters = 5000;
    hereMapController.camera.lookAtPointWithDistance(
        GeoCoordinates(LocationService.lat, LocationService.long),
        distanceToEarthInMeters);
  }
}
