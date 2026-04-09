import 'package:ceiba_fund_manager/app.dart';
import 'package:ceiba_fund_manager/core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  setupDependencies();
  runApp(const App());
}
