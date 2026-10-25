import 'package:casttime/app/app.dart';
import 'package:casttime/app/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();
  await setupDependencies();

  runApp(CasttimeApp());
}
