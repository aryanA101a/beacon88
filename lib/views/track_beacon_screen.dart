import 'package:beacon/view_model/track_beacon_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackBeaconScreen extends StatelessWidget {
  const TrackBeaconScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var trackBeaconViewModel = context.watch<TrackBeaconViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkResponse(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Track a beacon",
          style: TextStyle(color: Colors.black),
        ),
        // centerTitle: true,
        actions: [
          TextButton(
              onPressed: trackBeaconViewModel.passkeyField.isNotEmpty
                  ? () {
                      trackBeaconViewModel.track(context);
                    }
                  : null,
              child: Text("Track"))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
            child:
                const Text("Enter a passkey provided by the beacon initiator"),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  alignLabelWithHint: false,
                  contentPadding: EdgeInsets.all(12),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Passkey',
                  hintStyle: TextStyle(fontSize: 18),
                  // errorText: errorSnapshot.data == 0
                  //     ? Localization.of(context).categoryEmpty
                  //     : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                onChanged: (val) {
                  trackBeaconViewModel.setPasskeyField(val);
                },
              ))
        ],
      ),
    );
  }
}
