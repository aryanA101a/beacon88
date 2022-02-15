import 'dart:async';
import 'dart:ffi';

import 'package:geolocator/geolocator.dart';

class LocationService {
  static _handleLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
  }

  static Future<Position> getCurrentLocation() async {
    await _handleLocationPermission();
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // return await Geolocator.getCurrentPosition();
  }

  static Future<Stream<Position>> getCurrentLocationStream() async {
    await _handleLocationPermission();
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    return Geolocator.getPositionStream(locationSettings: locationSettings);

    // return await Geolocator.getCurrentPosition();
  }
}
