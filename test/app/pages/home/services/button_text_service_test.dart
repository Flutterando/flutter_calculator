import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_testes_teste/app/pages/home/services/button_text_service.dart';

void main() {
  ButtonTextService service;

  setUp(() {
    service = ButtonTextService();
  });

  group('ButtonTextService Test', () {
    test("Get text from switch", () {
      expect(service.itemClick(1), "%");
      expect(service.itemClick(2), "*");
      expect(service.itemClick(3), "/");
      expect(service.itemClick(4), "7");
      expect(service.itemClick(5), "8");
      expect(service.itemClick(6), "9");
    });
  });
}
