import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:flutter_testes_teste/app/pages/home/home_bloc.dart';
import 'package:flutter_testes_teste/app/pages/home/home_module.dart';

void main() {
  initModule(HomeModule());
  HomeBloc bloc;

  setUp(() {
    bloc = HomeModule.to.bloc<HomeBloc>();
  });

  group('HomeBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<HomeBloc>());
    });
    test("Receive expressions", () {
      bloc.typeExpressionIn.add("1");
      expect(bloc.typeExpressionOut, emits("1"));
    });
    test("Receive expressions and concat", () async {
      bloc.typeExpressionIn.add("AC");

      expect(
          bloc.typeExpressionOut,
          emitsInOrder([
            "",
            "1",
            "1+",
            "1+2",
          ]));

      bloc.typeExpressionIn.add("1");
      bloc.typeExpressionIn.add("+");
      bloc.typeExpressionIn.add("2");
    });

    test("Exec expression", () async {
      bloc.typeExpressionIn.add("AC");

      expect(
          bloc.typeExpressionOut,
          emitsInOrder([
            "",
            "1",
            "1+",
            "1+2",
            "3",
          ]));

      bloc.typeExpressionIn.add("1");
      bloc.typeExpressionIn.add("+");
      bloc.typeExpressionIn.add("2");
      bloc.typeExpressionIn.add("=");
    });

    test("Exec expression and start other", () async {
      bloc.typeExpressionIn.add("AC");

      expect(
          bloc.typeExpressionOut,
          emitsInOrder([
            "",
            "1",
            "1+",
            "1+2",
            "3",
            "5",
          ]));

      bloc.typeExpressionIn.add("1");
      bloc.typeExpressionIn.add("+");
      bloc.typeExpressionIn.add("2");
      bloc.typeExpressionIn.add("=");
      bloc.typeExpressionIn.add("5");
    });
    test("Exec expression and send plus", () async {
      bloc.typeExpressionIn.add("AC");

      expect(
          bloc.typeExpressionOut,
          emitsInOrder([
            "",
            "1",
            "1+",
            "1+2",
            "3",
            "3+",
          ]));

      bloc.typeExpressionIn.add("1");
      bloc.typeExpressionIn.add("+");
      bloc.typeExpressionIn.add("2");
      bloc.typeExpressionIn.add("=");
      bloc.typeExpressionIn.add("+");
    });

    test("Exec expression and not duplicate symbols", () async {
      bloc.typeExpressionIn.add("AC");

      expect(
          bloc.typeExpressionOut,
          emitsInOrder([
            "",
            "1",
            "1+",
            "1+2",
            "3",
            "3+",
            "3+",
          ]));

      bloc.typeExpressionIn.add("1");
      bloc.typeExpressionIn.add("+");
      bloc.typeExpressionIn.add("2");
      bloc.typeExpressionIn.add("=");
      bloc.typeExpressionIn.add("+");
      bloc.typeExpressionIn.add("+");
    });

    test("Not start with symbol *, /, % and +", () {
      bloc.typeExpressionIn.add("AC");
      expect(
          bloc.typeExpressionOut,
          emitsInOrder([
            "",
            "",
            "",
            "",
            "-",
            "",
          ]));
      bloc.typeExpressionIn.add("*");
      bloc.typeExpressionIn.add("+");
      bloc.typeExpressionIn.add("/");
      bloc.typeExpressionIn.add("-");
      bloc.typeExpressionIn.add("+");
    });

    test("mapNotSymbolLess Method", () {
      expect(bloc.mapNotSymbolLess("1"), "1");
      expect(bloc.mapNotSymbolLess("*"), "");
      expect(bloc.mapNotSymbolLess("/"), "");
      expect(bloc.mapNotSymbolLess("-"), "-");
    });

    test("mapACTap Method", () {
      expect(bloc.mapACTap("1"), "1");
      expect(bloc.mapACTap("AC"), "");
    });
    
    test("mapExpression Method", () {
      expect(bloc.mapExpression("1"), "1");
      bloc.cacheText = "100+100";
      expect(bloc.mapExpression("="), "200");
    });

    test("Clean monitor", () {
      bloc.typeExpressionIn.add("1");
      bloc.typeExpressionIn.add("+");
      bloc.typeExpressionIn.add("2");

      bloc.typeExpressionIn.add("AC");

      expect(bloc.typeExpressionOut, emits(""));
    });

    test("is numeric", () {
      expect(bloc.isNumeric("1"), true);
      expect(bloc.isNumeric("b"), false);
    });

    test("check result expression", () {
      expect(bloc.result("1+3"), "4");
      expect(bloc.result("1+"), "1+");
    });

    test("Exec percent %", () {
      bloc.typeExpressionIn.add("AC");
      expect(
          bloc.typeExpressionOut,
          emitsInOrder([
            "",
            "20",
            "0.2",
            "0.2*",
            "0.2*200",
            "40",
          ]));
      bloc.typeExpressionIn.add("20");
      bloc.typeExpressionIn.add("%");
      bloc.typeExpressionIn.add("*");
      bloc.typeExpressionIn.add("200");
      bloc.typeExpressionIn.add("=");
    });
  });
}
