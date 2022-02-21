import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class DatabaseService {
  static CollectionReference _firestoreCollection =
      FirebaseFirestore.instance.collection("beacon");

  static Future<void> setLocation(
      {required String docId, required Position position}) {
    return _firestoreCollection
        .doc(docId)
        .set({'location': GeoPoint(position.latitude, position.longitude)})
        .then((value) => log("Location Set"))
        .catchError((error) => log("Failed to set location: $error"));
  }

  static Future<void> deleteDoc({required String docId}) {
    return _firestoreCollection
        .doc(docId)
        .delete()
        .then((value) => log("Doc Deleted"))
        .catchError((error) => log("Failed to delete Doc: $error"));
  }

  static Future<void> updateLocation(
      {required String docId, required Position position}) {
    return _firestoreCollection
        .doc(docId)
        .update({'location': GeoPoint(position.latitude, position.longitude)})
        .then((value) => log("Location Updated"))
        .catchError((error) => log("Failed to update location: $error"));
  }

  static getBeaconLocationStream(String docId) {
    return _firestoreCollection.doc(docId).snapshots();
  }

  static Future<GeoPoint> getBeaconLocation(String docId) async {
    var location = await _firestoreCollection.doc(docId).get();
    return location["location"];
  }
}
