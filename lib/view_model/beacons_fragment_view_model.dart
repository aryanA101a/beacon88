import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:beacon/locator.dart';
import 'package:beacon/repository/database_service.dart';
import 'package:beacon/repository/location_service.dart';
import 'package:beacon/view_model/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';

void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(BeaconTask());
}

class BeaconsFragmentViewModel {
  static ReceivePort? _receivePort;

  static Future<void> initForegroundTask() async {
    await FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'notification_channel_id',
        channelName: 'Foreground Notification',
        channelDescription:
            'This notification appears when the foreground service is running.',
        channelImportance: NotificationChannelImportance.HIGH,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
        buttons: [
          const NotificationButton(id: 'sendButton', text: 'Send'),
          const NotificationButton(id: 'testButton', text: 'Test'),
        ],
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        // interval: 100,
        autoRunOnBoot: true,
        allowWifiLock: true,
      ),
      printDevLog: true,
    );
  }

  static Future<bool> startForegroundTask() async {
    log('sft');

    ReceivePort? receivePort;
    if (await FlutterForegroundTask.isRunningService) {
      receivePort = await FlutterForegroundTask.restartService();
    } else {
      receivePort = await FlutterForegroundTask.startService(
        notificationTitle: 'Foreground Service is running',
        notificationText: 'Tap to return to the app',
        callback: startCallback,
      );
    }

    if (receivePort != null) {
      _receivePort = receivePort;
      _receivePort?.listen((message) {
        DatabaseService.updateLocation(
            docId: getIt<HomeScreenViewModel>().passkey!, position: message);

        log(message.toString());
      });

      return true;
    }

    return false;
  }

  Future<bool> _stopForegroundTask() async {
    return await FlutterForegroundTask.stopService();
  }
}

class BeaconTask extends TaskHandler {
  StreamSubscription? streamSubscription;
  Timer? timer;
  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    log('onStart');
    Timer.periodic(Duration(seconds: 3), (timer) {
      log("testingForegrond");
    });
    // final timer =
    //     Timer(const Duration(seconds: 120), () => log('Timer finished'));

    // Stream locStream = await LocationService.getCurrentLocationStream();
    // streamSubscription = locStream.listen((event) {
    //   log("gotLocUpdate");
    //   sendPort?.send(event);
    // });
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {}

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    log("destroy");
    timer?.cancel();
    await streamSubscription?.cancel();
  }

  @override
  void onButtonPressed(String id) {
    // Called when the notification button on the Android platform is pressed.
    if (id == 'testButton') {
      FlutterForegroundTask.stopService();
    }
  }
}
