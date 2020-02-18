import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_parking/model/parking_spot_serializer.dart';
import 'package:just_parking/model/parkingspot.dart';

class ParkingSpotManager {
  ParkingSpot _parkingSpot;
  ParkingSpotSerializer _serializer;

  ParkingSpotManager() {
    _parkingSpot = ParkingSpot();
    _serializer = ParkingSpotSerializer(_parkingSpot);
  }

  void setParkingSpotInfo(
    String lot,
    String status,
    int spotNumber,
    double lng,
    double lat,
  ) {
    _parkingSpot.setLot(lot);
    _parkingSpot.setLocation(lng, lat);
    _parkingSpot.setSpotNumber(spotNumber);
    _parkingSpot.setStatus(status);
  }

  LatLng getParkingSpotLocation() {
    return _parkingSpot.getLocation();
  }

  void setParkingSpotUID(String uid) {
    _parkingSpot.setUID(uid);
  }

  String getParkingSpotUID() {
    return _parkingSpot.getUID();
  }

  ParkingSpot getParkingSpot() {
    return _parkingSpot;
  }

  Map<String, dynamic> serializeParkingSpotInfo() {
    return _serializer.serialize();
  }

  void deserializeParkingSpotInfo(var doc) {
    _parkingSpot = _serializer.deserialize(doc);
    _serializer = ParkingSpotSerializer(_parkingSpot);
  }
}
