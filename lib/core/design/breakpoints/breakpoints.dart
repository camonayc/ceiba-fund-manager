import 'package:ceiba_technical_test/core/design/breakpoints/device_type.dart';

abstract final class Breakpoints {
  static const double mobile = 0;
  static const double tablet = 700;
  static const double desktop = 1024;
  static const double widescreen = 1440;

  static DeviceType resolve(double width) {
    if (width >= widescreen) return DeviceType.widescreen;
    if (width >= desktop) return DeviceType.desktop;
    if (width >= tablet) return DeviceType.tablet;
    return DeviceType.mobile;
  }
}
