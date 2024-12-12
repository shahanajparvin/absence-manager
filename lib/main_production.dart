import 'package:absence_manager/core/flavor/flavor_config.dart';
import 'package:absence_manager/main.dart';


void main() {
  mainCommon(const FlavorConfig(
      flavorType: FlavorType.live,
      packageName: 'com.shahanajparvin.absence_manager'));
}
