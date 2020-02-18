import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_parking/controller/logic_manager.dart';
import 'package:just_parking/controller/parking_spot_manager.dart';

import 'package:just_parking/model/parkingspot.dart';
import 'package:just_parking/view/homescreen.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:url_launcher/url_launcher.dart';

class ReservationScreen extends StatefulWidget {
  final ParkingSpotManager _manager;
  final LogicManager _logicManager;

  ReservationScreen(this._manager, this._logicManager);

  @override
  State<StatefulWidget> createState() {
    return ReservationScreenState(_manager, _logicManager);
  }
}

class ReservationScreenState extends State<ReservationScreen> {
  ParkingSpotManager _manager;
  LogicManager _logicManager;
  Completer<GoogleMapController> mapController;
  GoogleMap googleMap;
  bool navigating = false;

  ReservationScreenState(this._manager, this._logicManager) {
    mapController = Completer<GoogleMapController>();
    googleMap = GoogleMap(
      mapType: MapType.hybrid,
      onMapCreated: (controller) {
        mapController.complete(controller);
      },
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      initialCameraPosition: CameraPosition(
        target: _manager.getParkingSpot().getLocation(),
        zoom: 50,
      ),
      markers: {
        Marker(
            position: _manager.getParkingSpot().getLocation(),
            markerId: MarkerId("1")),
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
                "${_manager.getParkingSpot().getLot()} spot # ${_manager.getParkingSpot().getSpotNumber()}")),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: googleMap),
/*          StreamBuilder<Object>(
              stream: Firestore.instance
                  .collection('parkingSpots')
                  .document(_manager.getParkingSpot().getUID())
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                DocumentSnapshot userDocument = snapshot.data;
                if (userDocument.data['reservedBy'] !=
                    _logicManager.getUser().getUID())
                  return Text(
                    "this spot has been reserved",
                    style: TextStyle(fontSize: 25),
                  );
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text("Get Directions",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          String origin = "";
                          String dest = "";
                          origin += _logicManager
                              .getUser()
                              .getCurrentLocation()
                              .latitude
                              .toString();
                          origin += ",";
                          origin += _logicManager
                              .getUser()
                              .getCurrentLocation()
                              .longitude
                              .toString();

                          dest += _manager
                              .getParkingSpot()
                              .getLocation()
                              .latitude
                              .toString();
                          dest += ",";
                          dest += _manager
                              .getParkingSpot()
                              .getLocation()
                              .longitude
                              .toString();

                          await Firestore.instance
                              .collection('parkingSpots')
                              .document(_manager.getParkingSpot().getUID())
                              .updateData({'status': ParkingSpot.UNAVAILABLE});
                          _launchMapsUrl(origin, dest);
                        },
                        color: Colors.green,
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.red,
                        child: Text("Cancel Reservation",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          _manager.getParkingSpot().setReservedBy(null);
                          _manager
                              .getParkingSpot()
                              .setStatus(ParkingSpot.AVAILABLE);
                          await Firestore.instance
                              .collection('parkingSpots')
                              .document(_manager.getParkingSpot().getUID())
                              .updateData(_manager.serializeParkingSpotInfo());

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(_logicManager)));
                          //dispose();
                        },
                      ),
                    )
                  ],
                );
              })*/
          Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                    
                icon: Icon(Icons.navigation),
                label: navigating? Text("End Reservation"):Text("Cancel Reservation"),
                onPressed: () async {
                  _manager.getParkingSpot().setReservedBy(null);
                  _manager.getParkingSpot().setStatus(ParkingSpot.AVAILABLE);
                  await Firestore.instance
                      .collection('parkingSpots')
                      .document(_manager.getParkingSpot().getUID())
                      .updateData(_manager.serializeParkingSpotInfo());

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(_logicManager)));
                  //dispose();
                },
              )),
              Expanded(
                child: Visibility(
                  visible: !navigating,
                                  child: FlatButton.icon(
                    icon: Icon(Icons.navigation),
                    label: Text("get directions"),
                    onPressed: () async {
                      String origin = "";
                      String dest = "";
                      origin += _logicManager
                          .getUser()
                          .getCurrentLocation()
                          .latitude
                          .toString();
                      origin += ",";
                      origin += _logicManager
                          .getUser()
                          .getCurrentLocation()
                          .longitude
                          .toString();

                      dest += _manager
                          .getParkingSpot()
                          .getLocation()
                          .latitude
                          .toString();
                      dest += ",";
                      dest += _manager
                          .getParkingSpot()
                          .getLocation()
                          .longitude
                          .toString();

                      await Firestore.instance
                          .collection('parkingSpots')
                          .document(_manager.getParkingSpot().getUID())
                          .updateData({'status': ParkingSpot.UNAVAILABLE});
                      _launchMapsUrl(origin, dest);
                      setState(() {
                        navigating = true;
                      });
                    },
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _launchMapsUrl(String originPlaceId, String destinationPlaceId) async {
    print(originPlaceId);
    print(destinationPlaceId);

    String mapOptions = [
      'origin=$originPlaceId',
      'origin_place_id=$originPlaceId',
      'destination=$destinationPlaceId',
      'destination_place_id=$destinationPlaceId',
      'dir_action=navigate'
    ].join('&');
    final url = 'https://www.google.com/maps/dir/api=1&$mapOptions';
    final url2 =
        "https://www.google.com/maps/dir/$originPlaceId/$destinationPlaceId";
    print(url);

    if (await canLaunch(url)) {
      await launch(url2);
    } else {
      throw 'Could not launch $url';
    }
  }
}
