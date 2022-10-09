// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'package:lazywash/ui/page/widgets/user_location.dart';
import 'package:location/location.dart';

class LocationService {
  static double lat = 0;
  static double long = 0;
  Location location = Location();
  StreamController<UserLocation> _locationStreamController =
      StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationStreamController.stream;

  LocationService() {
    location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationStreamController.add(UserLocation(
                latitude: locationData.latitude!,
                longitude: locationData.longitude!));

            lat = locationData.latitude!;
            long = locationData.longitude!;
          }
        });
      }
    });
  }

  void dispose() => _locationStreamController.close();
}
