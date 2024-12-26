import 'package:absence_manager/core/flavor/flavor_config.dart';
import 'package:absence_manager/main_common.dart';

void main() {
  mainCommon(const FlavorConfig(
      flavorType: FlavorType.development,
      packageName: 'ch.dinnova.letsplan.dev'),);

}
