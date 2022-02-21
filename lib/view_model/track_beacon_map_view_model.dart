import 'dart:developer';

import 'package:beacon/repository/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackBeaconMapViewModel with ChangeNotifier {
  LatLng? _initialLocation;
  LatLng? get initialLocation => _initialLocation;
  BitmapDescriptor _pinLocationIcon = BitmapDescriptor.defaultMarker;
  late Map<MarkerId, Marker> _markers;
  Map<MarkerId, Marker> get markers => _markers;
  final MarkerId markerId = MarkerId("1");

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  BitmapDescriptor get pinLocationIcon => _pinLocationIcon;

  late LatLng _locationPosition;
  LatLng get locationPosition => _locationPosition;

  bool locationServiceActive = true;

  TrackBeaconMapViewModel() {
    _markers = <MarkerId, Marker>{};
  }

  initialization(String passkey) async {
    DatabaseService.getBeaconLocation(passkey).then(
        (value) => _initialLocation = LatLng(value.latitude, value.longitude));
    await getBeaconLocation(passkey);
  }

  getBeaconLocation(String passkey) async {
    var location = DatabaseService.getBeaconLocationStream(passkey);

    location.listen(
      (currentLocation) {
        log("*****${currentLocation["location"].longitude}");
        _locationPosition = LatLng(
          currentLocation["location"].latitude,
          currentLocation["location"].longitude,
        );

        print(_locationPosition);

        _markers.clear();

        Marker marker = Marker(
          markerId: markerId,
          position: LatLng(
            _locationPosition.latitude,
            _locationPosition.longitude,
          ),
          icon: pinLocationIcon,
          draggable: true,
          onDragEnd: ((newPosition) {
            _locationPosition = LatLng(
              newPosition.latitude,
              newPosition.longitude,
            );

            notifyListeners();
          }),
        );

        _markers[markerId] = marker;

        notifyListeners();
      },
    );
  }

  setMapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  takeSnapshot() {
    return _mapController.takeSnapshot();
  }
}
