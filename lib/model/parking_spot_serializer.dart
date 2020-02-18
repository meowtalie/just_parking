import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_parking/model/parkingspot.dart';
import 'package:just_parking/model/serializable.dart';
import 'package:just_parking/model/serializer.dart';

class ParkingSpotSerializer implements Serializer {
  ParkingSpot spot;

  ParkingSpotSerializer(this.spot);

  @override
  Serializable deserialize(doc) {
    ParkingSpot spot = ParkingSpot();

    GeoPoint point = doc['location'];

    spot.setLot(doc['lot']);
    spot.setUID(doc['uid']);
    spot.setLocation(point.longitude, point.latitude);
    spot.setStatus(doc['status']);
    spot.setSpotNumber(doc['spotNumber']);
    spot.setReservedBy(doc['reservedBy']);

    return spot;
  }

  @override
  Map<String, dynamic> serialize() {
    return {
      'uid': spot.getUID(),
      'lot': spot.getLot(),
      'status': spot.getStatus(),
      'spotNumber': spot.getSpotNumber(),
      'location':
          GeoPoint(spot.getLocation().latitude, spot.getLocation().longitude),
      'reservedBy': spot.getReservedBy()
    };
  }
}
