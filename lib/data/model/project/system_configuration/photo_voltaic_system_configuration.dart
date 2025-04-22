
import 'package:web_demo/data/model/project/system_configuration/system_configuration.dart';

class Configuration {
  final SolarPanel? solarPanel;
  final ChargeController? chargeController;
  final Inverter? inverter;
  final Battery? battery;
  final PVArrayCombinerBox? pvArrayCombinerBox;
  final MountingBracket mountingBracket;
  final PVCable pvCable;
  final ConnectorCable? connectorCable;
  final MC4CompatibleConnector mc4CompatibleConnector;

  Configuration({
    this.solarPanel,
    this.chargeController,
    this.inverter,
    this.battery,
    this.pvArrayCombinerBox,
    required this.mountingBracket,
    required this.pvCable,
    this.connectorCable,
    required this.mc4CompatibleConnector,
  });
}
