import 'package:flutter/material.dart';

class Config {
  static const String APP_NAME = "Feel";
  static const String VERSION = "0.0.1";
  static const Color PRIMARY_COLOR = Colors.blue;
  static const UnderlineInputBorder BORDER = UnderlineInputBorder(
    borderSide: BorderSide(color: PRIMARY_COLOR),
  );
  static const EdgeInsets CARD_MARGIN =
      EdgeInsets.symmetric(horizontal: 15, vertical: 5);
}
