import 'package:ceiba_fund_manager/core/design/breakpoints/breakpoints.dart';
import 'package:ceiba_fund_manager/core/design/breakpoints/device_type.dart';

class ResponsiveValue<T> {
  const ResponsiveValue({
    T? mobile,
    T? tablet,
    T? desktop,
    T? widescreen,
  }) : assert(
         mobile != null ||
             tablet != null ||
             desktop != null ||
             widescreen != null,
         'At least one value must be provided.',
       ),
       _mobile = mobile,
       _tablet = tablet,
       _desktop = desktop,
       _widescreen = widescreen;

  final T? _mobile;
  final T? _tablet;
  final T? _desktop;
  final T? _widescreen;

  T get mobile => (_mobile ?? _tablet ?? _desktop ?? _widescreen)!;
  T get tablet => _tablet ?? mobile;
  T get desktop => _desktop ?? tablet;
  T get widescreen => _widescreen ?? desktop;

  T resolve(DeviceType deviceType) => switch (deviceType) {
    DeviceType.mobile => mobile,
    DeviceType.tablet => tablet,
    DeviceType.desktop => desktop,
    DeviceType.widescreen => widescreen,
  };

  T resolveWidth(double width) => resolve(Breakpoints.resolve(width));
}
