import 'dart:async';
import 'dart:math';

import 'package:beacon/models/beacon_model.dart';
import 'package:beacon/repository/database_service.dart';
import 'package:beacon/repository/location_service.dart';
import 'package:beacon/view_model/beacons_fragment_view_model.dart';
import 'package:flutter/cupertino.dart';

class BeaconServices {
  static _generatePasskey() {
    return (DateTime.now().millisecondsSinceEpoch +
            Random.secure().nextInt(999))
        .toRadixString(16);
  }

  static Future<Beacon> createBeacon() async {
    String passkey = _generatePasskey();

    DatabaseService.setLocation(
        docId: passkey, position: await LocationService.getCurrentLocation());

    return Beacon(passkey: passkey);
  }
}
