// ignore_for_file: deprecated_member_use_from_same_package, unused_field

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/routing.dart';
import 'package:lazywash/ui/page/penyedia/detail_history_penyedia.dart';
import 'package:lazywash/ui/page/widgets/location_service.dart';

class HereMapRoute extends StatefulWidget {
  const HereMapRoute({Key? key}) : super(key: key);

  @override
  State<HereMapRoute> createState() => _HereMapRouteState();
}

class _HereMapRouteState extends State<HereMapRoute> {
  late HereMapController _controller;
  late MapPolyline _mapPolyline;

  LocationService locationService = LocationService();
  double startlatitude = 0;
  double startlongitude = 0;

  @override
  void initState() {
    super.initState();
    locationService.locationStream.listen((userLocation) {
      setState(() {
        startlatitude = userLocation.latitude;
        startlongitude = userLocation.longitude;
      });
    });
  }

  @override
  void dispose() {
    locationService.dispose();
    _controller.finalize();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HereMap(
          onMapCreated: onMapCreated,
        ),
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

  Future<void> drawRoute(GeoCoordinates start, GeoCoordinates end,
      HereMapController hereMapController) async {
    /// untuk routing engine
    RoutingEngine routingEngine = RoutingEngine();

    ///buat way point
    Waypoint startWayPoint = Waypoint.withDefaults(start);
    Waypoint endWayPoint = Waypoint.withDefaults(end);
    List<Waypoint> wayPoints = [startWayPoint, endWayPoint];

    ///hitung rute
    routingEngine.calculateBicycleRoute(wayPoints, BicycleOptions(),
        (routingError, routes) {
      if (routingError == null) {
        var route = routes?.first;

        ///buat polyline
        GeoPolyline routeGeoPolyLine = GeoPolyline(route!.polyline);

        ///visual represenasi untuk polyline
        double depth = 20;
        _mapPolyline = MapPolyline(routeGeoPolyLine, depth, Colors.blue);

        /// pasang di controller untuk gambar di peta
        hereMapController.mapScene.addMapPolyline(_mapPolyline);
      }
    });
  }

  void onMapCreated(HereMapController hereMapController) async {
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

    drawRoute(
        GeoCoordinates(LocationService.lat, LocationService.long),
        GeoCoordinates(
            DetailHistoryPenyedia.pesanlat, DetailHistoryPenyedia.pesanlong),
        hereMapController);

    double distanceToEarthInMeters = 2000;
    hereMapController.camera.lookAtPointWithDistance(
        GeoCoordinates(LocationService.lat, LocationService.long),
        distanceToEarthInMeters);
  }
}
