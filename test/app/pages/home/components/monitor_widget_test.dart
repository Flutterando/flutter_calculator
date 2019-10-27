import 'package:bloc_pattern/bloc_pattern_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_testes_teste/app/pages/home/components/monitor_widget.dart';
import 'package:flutter_testes_teste/app/pages/home/home_module.dart';

main() {
  setUp(() {
    initModule(HomeModule());
  });
  testWidgets('MonitorWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(MonitorWidget()));
    final textFinder = find.text('0');
    expect(textFinder, findsOneWidget);
  });
}
