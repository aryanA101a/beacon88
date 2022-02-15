import 'dart:developer';

import 'package:beacon/models/beacon_model.dart';
import 'package:beacon/repository/location_service.dart';
import 'package:beacon/view_model/home_screen_view_model.dart';
import 'package:beacon/views/beacons_fragment.dart';
import 'package:beacon/views/initial_home_screen_fragment.dart';
import 'package:beacon/views/track_beacon_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeScreenViewModel = context.watch<HomeScreenViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Beacon",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  color: Colors.orangeAccent.shade700,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text(
                    'New Beacon',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    homeScreenViewModel.newBeacon();
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1, color: Colors.grey.shade600),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  child: Text(
                    'Track with a code',
                    style: TextStyle(color: Colors.orangeAccent.shade700),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrackBeaconScreen(),
                        ));
                  },
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: homeScreenViewModel.beacon != null
              ? BeaconsFragment(homeScreenViewModel: homeScreenViewModel)
              : const InitialHomeScreenFragment(),
        )
      ]),
    );
  }
}
