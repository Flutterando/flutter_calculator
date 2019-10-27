import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';
import 'package:flutter_testes_teste/app/app_module.dart';
import 'package:flutter_testes_teste/app/pages/home/components/button_click_widget.dart';
import 'package:flutter_testes_teste/app/pages/home/home_module.dart';
import 'package:flutter_testes_teste/app/pages/home/home_page.dart';

main() {
  setUp(() {
    initModules([
      AppModule(),
      HomeModule(),
    ]);
  });

  testWidgets('Tap expression', (WidgetTester tester) async {
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(600, 800));
    await tester.pumpWidget(buildTestableWidget(HomePage()));

    await tester.tap(find.widgetWithText(ButtonClickWidget, "9"));
    await tester.tap(find.widgetWithText(ButtonClickWidget, "+"));
    await tester.tap(find.widgetWithText(ButtonClickWidget, "2"));
    await tester.tap(find.widgetWithText(ButtonClickWidget, "="));
    await tester.pump(Duration(seconds: 2));
    final resultFinder = find.widgetWithText(AutoSizeText, '11');
    expect(resultFinder, findsOneWidget);
  });
}
