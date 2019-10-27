import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_testes_teste/app/pages/home/components/button_click_widget.dart';
import 'package:flutter_testes_teste/app/pages/home/home_module.dart';

main() {
  setUp(() {
    initModule(HomeModule());
  });

  testWidgets('ButtonClickWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(ButtonClickWidget(
      text: "test",
    )));
    final textFinder = find.text('test');
    expect(textFinder, findsOneWidget);
  });
}
