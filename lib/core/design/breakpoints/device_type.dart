enum DeviceType {
  mobile,
  tablet,
  desktop,
  widescreen
  ;

  bool get isMobileFamily => index < DeviceType.tablet.index;
  bool get isTabletOrLarger => index >= tablet.index;
  bool get isDesktopFamily => index >= desktop.index;
}
