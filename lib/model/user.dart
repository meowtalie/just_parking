import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_parking/model/serializable.dart';

class User extends Serializable {
  String _email;
  String _password;
  LatLng _currentLocation;

  LatLng getCurrentLocation() => _currentLocation;
  void setCurrentLocation(double longitude, double latitude) => _currentLocation = LatLng(latitude,longitude);

  String getEmail() => _email;
  void setEmail(value) => _email = value;

  String getPassword() => _password;
  void setPassword(value) => _password = value;
}
