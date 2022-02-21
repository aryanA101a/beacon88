import 'dart:developer';

import 'package:beacon/locator.dart';
import 'package:beacon/models/beacon_model.dart';
import 'package:beacon/view_model/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BeaconsFragment extends StatefulWidget {
  const BeaconsFragment({
    Key? key,
    required this.homeScreenViewModel,
  }) : super(key: key);

  final HomeScreenViewModel homeScreenViewModel;

  @override
  State<BeaconsFragment> createState() => _BeaconsFragmentState();
}

class _BeaconsFragmentState extends State<BeaconsFragment> {
  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Beacons",
              style: TextStyle(color: Colors.grey.shade800),
            ),
          ),
          BeaconTile(
            beacon: widget.homeScreenViewModel.beacon!,
          )
        ],
      ),
    );
  }
}

class BeaconTile extends StatelessWidget {
  const BeaconTile({
    required this.beacon,
    Key? key,
  }) : super(key: key);
  final Beacon beacon;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key("1"),
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {
          getIt<HomeScreenViewModel>().disposeBeacon();
        }),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              getIt<HomeScreenViewModel>().disposeBeacon();
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.orangeAccent.shade700,
          child: Icon(
            Icons.share_location_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(beacon.passkey),
        trailing: InkResponse(
          onTap: () {
            Clipboard.setData(ClipboardData(text: beacon.passkey))
                .then((value) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Copied!")));
            });
          },
          child: Icon(Icons.copy_rounded),
        ),
      ),
    );
  }
}
