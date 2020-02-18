import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_parking/model/serializable.dart';

class ParkingSpot extends Serializable {
  static const HOLD = 'hold';
  static const AVAILABLE = 'available';
  static const UNAVAILABLE = 'unavailable';
  LatLng _location;
  String _lot;
  int _spotNumber;
  String _status;
  String _reservedBy;

  LatLng getLocation() => _location;
  void setLocation(double lng, double lat) {
    _location = LatLng(lat, lng);
    print(_location);
  }

  String getLot() => _lot;
  void setLot(String lot) => _lot = lot;

  int getSpotNumber() => _spotNumber;
  void setSpotNumber(int sn) => _spotNumber = sn;

  String getStatus() => _status;
  void setStatus(String st) => _status = st;

  String getReservedBy() => _reservedBy;
  void setReservedBy(value) => _reservedBy = value;
}
