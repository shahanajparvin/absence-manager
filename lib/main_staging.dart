import 'package:absence_manager/core/flavor/flavor_config.dart';
import 'package:absence_manager/main_common.dart';

void main() {
  mainCommon(const FlavorConfig(
      flavorType: FlavorType.staging,
      packageName: 'com.shahanajparvin.absence_manager.staging'));
}
