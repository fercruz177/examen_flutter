import 'dart:convert';

import 'package:examen_flutter/services/fcm_service.dart';
import 'package:flutter/material.dart';
import 'package:examen_flutter/core/service_locator.dart' as sl;
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

import 'core/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FcmService.init();
  sl.init();
  final themeStr = await rootBundle.loadString('assets/styles/main_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  runApp(MyApp(theme));
}

class MyApp extends StatelessWidget {
  const MyApp(this.theme, {super.key});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: theme,
      routerConfig: myRouter,
    );
  }
}
