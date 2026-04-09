import 'package:ceiba_technical_test/app.dart';
import 'package:ceiba_technical_test/core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  setupDependencies();
  runApp(const App());
}
