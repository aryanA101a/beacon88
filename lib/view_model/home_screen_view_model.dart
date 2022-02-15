import 'dart:math';

import 'package:beacon/main.dart';
import 'package:beacon/models/beacon_model.dart';
import 'package:beacon/repository/beacon_services.dart';
import 'package:beacon/repository/database_service.dart';
import 'package:beacon/repository/location_service.dart';
import 'package:beacon/view_model/beacons_fragment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class HomeScreenViewModel with ChangeNotifier {
  bool _isLoading = false;
  Beacon? _beacon;
  Beacon? get beacon => _beacon;
  String? _passkey;
  String? get passkey => _passkey;

  HomeScreenViewModel() {
    BeaconsFragmentViewModel.initForegroundTask();
  }
  disposeBeacon() {
    if (_beacon != null) {
      // _beacon!.streamSubscription.cancel();
      FlutterForegroundTask.stopService();
      DatabaseService.deleteDoc(docId: _beacon!.passkey);
      _beacon = null;
      notifyListeners();
    }
  }

  newBeacon() async {
    _beacon = await BeaconServices.createBeacon();
    _passkey = _beacon?.passkey;
    BeaconsFragmentViewModel.startForegroundTask();

    notifyListeners();
  }
}
