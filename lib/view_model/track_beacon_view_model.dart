import 'package:beacon/views/track_beacon_map_screen.dart';
import 'package:flutter/material.dart';

class TrackBeaconViewModel with ChangeNotifier {
  String _passkeyField = "";
  String get passkeyField => _passkeyField;
  setPasskeyField(String passkey) {
    _passkeyField = passkey;
    notifyListeners();
  }

  track(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrackBeaconMapScreen(
            passkey: _passkeyField,
          ),
        ));
  }
}
