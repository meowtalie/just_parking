import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_parking/controller/campusmapscreen_controller.dart';
import 'package:just_parking/controller/logic_manager.dart';
import 'package:just_parking/controller/parking_spot_manager.dart';
import 'package:just_parking/model/appdialog.dart';
import 'package:just_parking/model/parkingspot.dart';
import 'package:just_parking/model/user.dart';
import 'package:just_parking/view/homescreen.dart';
import 'package:just_parking/view/reseravtionscreen.dart';
import 'package:just_parking/view/splashscreen.dart';
import 'package:just_parking/view/campusmapscreen.dart';
import 'package:just_parking/model/user.dart';

class HomeScreenController {
  HomeScreenState state;
  LogicManager _manager;
  User user;
  HomeScreenController(this.state, this._manager);

  void logout() async {
    try {
      await _manager.logout();
      Navigator.pushReplacement(state.context,
          MaterialPageRoute(builder: (context) => SplashScreen()));
    } catch (e) {
      AppDialog.showErrorDialog(state.context, e.message);
    }
  }

  getUserLocation() {
    print(_manager.getUser().getCurrentLocation());
    return _manager.getUser().getCurrentLocation();
  }

  LogicManager getLogicManager() {
    return _manager;
  }

  void reserveSpot(
      AsyncSnapshot snapshot, int index, BuildContext context) async {
    try {
      ParkingSpotManager manager = ParkingSpotManager();
      manager.deserializeParkingSpotInfo(snapshot.data.documents[index].data);
      manager.getParkingSpot().setStatus(ParkingSpot.HOLD);

      manager
          .getParkingSpot()
          .setReservedBy(getLogicManager().getUser().getUID());

      var ref = Firestore.instance
          .collection('parkingSpots')
          .document(manager.getParkingSpot().getUID());
      await Firestore.instance.runTransaction((transaction) async {
        return transaction.get(ref).then((doc) async {
          if (doc.data['reservedBy'] == null) {
            transaction.update(ref, manager.serializeParkingSpotInfo());
          } else {
            AppDialog.showErrorDialog(
                state.context, "spot has already been held");
            return;
          }
        });
      });
/*
    Firestore.instance
        .collection('parkingSpots')
        .document(manager.getParkingSpot().getUID())
        .updateData(manager.serializeParkingSpotInfo());
*/
      Navigator.pushReplacement(
          state.context,
          MaterialPageRoute(
              builder: (context) =>
                  ReservationScreen(manager, getLogicManager())));
    } catch (e) {
      AppDialog.showErrorDialog(state.context, "spot has already been held");
    }
  }
  void campusMapPage(){
    Navigator. push(state.context, MaterialPageRoute(
      builder: (context) => CampusMapPage(user),
    ));
  }
}
