import 'package:campus_safar/utils/theme/theme.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

/// --Use this class to setup themes, initial Bindings ,any animations and much more
class CSApp extends StatelessWidget {
  const CSApp({super.key, required this.home});

  final Widget home;
  static bool isWeb = kIsWeb;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(
      connectionNotificationOptions: const ConnectionNotificationOptions(),
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: CSAppTheme.lightTheme,
          darkTheme: CSAppTheme.darkTheme,
          home: home),
    );
  }
}
