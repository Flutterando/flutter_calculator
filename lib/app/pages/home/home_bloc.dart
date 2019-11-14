import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:expressions/expressions.dart';

class HomeBloc extends BlocBase {
  String cacheText = "";
  bool isResolved = false;

  final _typeExpression$ = BehaviorSubject<String>();
  Sink<String> get typeExpressionIn => _typeExpression$.sink;
  Stream<String> get typeExpressionOut => _typeExpression$.stream
      .map(mapNotSymbolLess)
      .map(mapACTap)
      .map(mapExpression);

  String mapNotSymbolLess(String value) {
    if ((cacheText.isEmpty ||
            (cacheText.length == 1 && !isNumeric(cacheText))) &&
        (value == "+" || value == "*" || value == "/" || value == "%")) {
      return "";
    } else {
      return value;
    }
  }

  String mapACTap(String value) {
    if (value == "AC") {
      cacheText = "";
      return "";
    }
    return value;
  }

  String mapExpression(String value) {
    if (value.isEmpty) {
      return "";
    }

    if (value == "%") {
      cacheText = result("$cacheText*0.01");
      return cacheText;
    }

    if (value == "=") {
      cacheText = result(cacheText);
      isResolved = true;
      return cacheText;
    }
    if (cacheText.length > 0 &&
        !isNumeric(value) &&
        !isNumeric(cacheText[cacheText.length - 1])) {
      cacheText = cacheText.substring(0, cacheText.length - 1);
    }

    if (isResolved && isNumeric(value)) {
      cacheText = value;
    } else {
      cacheText = "$cacheText$value";
    }
    isResolved = false;
    return cacheText;
  }

  String result(String expressionText) {
    try {
      Expression expression = Expression.parse(expressionText);
      final evaluator = const ExpressionEvaluator();
      var r = evaluator.eval(expression, null);
      return r.toString().contains(".0")
          ? r.toString().replaceFirst(".0", "")
          : r.toString();
    } catch (e) {
      return expressionText;
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  void dispose() {
    _typeExpression$.close();
    super.dispose();
  }
}
