import 'package:ceiba_fund_manager/core/design/breakpoints/breakpoints.dart';
import 'package:ceiba_fund_manager/core/design/breakpoints/device_type.dart';
import 'package:ceiba_fund_manager/core/design/breakpoints/responsive_value.dart';
import 'package:flutter/widgets.dart';

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  DeviceType get deviceType => Breakpoints.resolve(screenWidth);

  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;
  bool get isWidescreen => deviceType == DeviceType.widescreen;

  bool get isMobileFamily => deviceType.isMobileFamily;

  bool get isTabletOrLarger => deviceType.isTabletOrLarger;

  bool get isDesktopFamily => deviceType.isDesktopFamily;

  T responsive<T>({
    T? mobile,
    T? tablet,
    T? desktop,
    T? widescreen,
  }) => ResponsiveValue<T>(
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
    widescreen: widescreen,
  ).resolve(deviceType);
}
