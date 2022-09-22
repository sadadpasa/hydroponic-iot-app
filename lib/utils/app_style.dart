import 'package:flutter/material.dart';

Color primary = const Color(0xFF2666DF);

class Styles {
  static Color primaryColor = primary;
  static Color textColor = const Color(0xFF3b3b3b);
  static Color bgColor = const Color(0xFFF2F6FC);
  static Color bgColor2 = const Color(0xFFeeedf2);
  static double disabledColorOp = 0.5;
  static double disabledTextOp = 0.5;
  static TextStyle textStyle =
      TextStyle(fontSize: 10, color: textColor, fontWeight: FontWeight.w500);
  static TextStyle header1 =
      TextStyle(fontSize: 26, color: textColor, fontWeight: FontWeight.bold);
  static TextStyle header2 =
      TextStyle(fontSize: 21, color: textColor, fontWeight: FontWeight.bold);
  static TextStyle header3 =
      TextStyle(fontSize: 17, color: textColor, fontWeight: FontWeight.w500);
  static TextStyle header4 = TextStyle(
      fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500);
}
