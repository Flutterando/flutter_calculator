import 'package:bloc_pattern/bloc_pattern.dart';

class ButtonTextService {
  String itemClick(int index) {
    switch (index) {
      case 0:
        return "AC";
      case 1:
        return "%";
      case 2:
        return "*";
      case 3:
        return "/";
      case 4:
        return "7";
      case 5:
        return "8";
      case 6:
        return "9";
      case 7:
        return "-";
      case 8:
        return "4";
      case 9:
        return "5";
      case 10:
        return "6";
      case 11:
        return "+";
      case 12:
        return "1";
      case 13:
        return "2";
      case 14:
        return "3";
      case 15:
        return "=";
      case 16:
        return "0";
      case 17:
        return ".";
    }
  }
}
