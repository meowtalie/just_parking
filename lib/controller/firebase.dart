import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_parking/controller/parking_spot_manager.dart';
import 'package:just_parking/controller/user_manager.dart';

class Firebase {
  static Firestore firestore = Firestore.instance;

  Future<void> createUserDoc(UserManager userManager) async {
    await firestore
        .collection('users')
        .document(userManager.getUserUID())
        .setData(userManager.serializeUserInfo());
  }

  Future<Map<String, dynamic>> getUserDoc(String uid) async {
    DocumentSnapshot snapshot =
        await firestore.collection('users').document(uid).get();
    return snapshot.data;
  }

  Future<void> createParkingSpotDoc(
      ParkingSpotManager parkingSpotManager) async {
    var result = await firestore
        .collection('parkingSpots')
        .add(parkingSpotManager.serializeParkingSpotInfo());

    await firestore
        .collection('parkingSpots')
        .document(result.documentID)
        .updateData({'uid': result.documentID});
  }

  Future<Map<String, dynamic>> getParkingSpotDoc(String uid) async {
    DocumentSnapshot snapshot =
        await firestore.collection('parkingSpots').document(uid).get();
    return snapshot.data;
  }
}
