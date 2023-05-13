

import 'package:test_ososs/core/mediators/communication_types/base_communication.dart';

enum Status { startup, authorized, unauthorized }

class AppStatus extends CommunicationType{
  final Status data;

  AppStatus({this.data = Status.startup});
}

//enum ValidationVehicleTaype { VehiclesOwnership, VehiclesUsage}
// class ValidationVehicle extends CommunicationType
// {
//   final VehiclesOwnership dataOwnership;
//   final VehiclesUsage dataUsage;
//   ValidationVehicle({this.dataOwnership=VehiclesOwnership.unset,this.dataUsage=VehiclesUsage.unset});
// }