import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' as p;
import 'package:flutter_testes_teste/app/app_module.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;

void main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(AppModule());
  if (p.Platform.isIOS || p.Platform.isAndroid)
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
