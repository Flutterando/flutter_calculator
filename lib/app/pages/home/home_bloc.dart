import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:expressions/expressions.dart';

class HomeBloc extends BlocBase {
  String listTexts = "";
  bool isResolved = false;

  final _typeExpression$ = BehaviorSubject<String>();
  Sink<String> get typeExpressionIn => _typeExpression$.sink;
  Stream<String> get typeExpressionOut => _typeExpression$.stream.map((t) {
        if ((listTexts.isEmpty ||
                (listTexts.length == 1 && !isNumeric(listTexts))) &&
            (t == "+" || t == "*" || t == "/" || t == "%")) {
          return "";
        }

        if (t == "AC") {
          listTexts = "";
          return "";
        }

        if (t == "%") {
          listTexts = result("$listTexts*0.01");
          return listTexts;
        }

        if (t == "=") {
          listTexts = result(listTexts);
          isResolved = true;
          return listTexts;
        }
        if (listTexts.length > 0 &&
            !isNumeric(t) &&
            !isNumeric(listTexts[listTexts.length - 1])) {
          listTexts = listTexts.substring(0, listTexts.length - 1);
        }

        if (isResolved && isNumeric(t)) {
          listTexts = t;
        } else {
          listTexts = "${listTexts}${t}";
        }
        isResolved = false;
        return listTexts;
      });

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
    return double.parse(s, (e) => null) != null;
  }

  @override
  void dispose() {
    _typeExpression$.close();
    super.dispose();
  }
}
