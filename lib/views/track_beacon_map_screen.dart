import 'package:beacon/view_model/track_beacon_map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class TrackBeaconMapScreen extends StatefulWidget {
  final String passkey;
  const TrackBeaconMapScreen({Key? key, required this.passkey})
      : super(key: key);

  @override
  _TrackBeaconMapScreenState createState() => _TrackBeaconMapScreenState();
}

class _TrackBeaconMapScreenState extends State<TrackBeaconMapScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TrackBeaconMapViewModel>().initialization(widget.passkey);
  }

  @override
  Widget build(BuildContext context) {
    TrackBeaconMapViewModel trackBeaconMapViewModel =
        context.watch<TrackBeaconMapViewModel>();
    return Scaffold(
        appBar: AppBar(
          title: Text("Tracking Beacon"),
          backgroundColor: Colors.orangeAccent,
        ),
        body: trackBeaconMapViewModel.initialLocation != null
            ? Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: trackBeaconMapViewModel.initialLocation!,
                        zoom: 18,
                      ),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      markers: Set<Marker>.of(
                          trackBeaconMapViewModel.markers.values),
                      onMapCreated: (GoogleMapController controller) async {
                        trackBeaconMapViewModel.setMapController(controller);
                      },
                    ),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()));
  }
}
