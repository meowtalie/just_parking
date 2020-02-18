import 'package:just_parking/model/serializable.dart';

abstract class Serializer {
  Map<String, dynamic> serialize();
  Serializable deserialize(var doc);
}
