
import 'package:test_ososs/core/mediators/bloc_hub/hub.dart';
import 'package:test_ososs/core/mediators/communication_types/base_communication.dart';

abstract class BlocMember {
  BlocHub blocHub;
  String name;

  void receive(String from, CommunicationType data) {}

  void sendTo(CommunicationType data, String receiverName) {
    print("sdfdsfdsfdsf");
    blocHub.sendToByName(name, data, receiverName);
  }

  void sendToAll(CommunicationType data) {
    blocHub.sendToAll(name, data);
  }
}
