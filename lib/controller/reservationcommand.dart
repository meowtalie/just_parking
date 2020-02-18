import 'package:just_parking/controller/logic_manager.dart';
import 'package:just_parking/controller/parking_spot_manager.dart';

abstract class ReservationCommand {
  Future<void> execute(LogicManager manager, ParkingSpotManager parkingSpotManager);
}
