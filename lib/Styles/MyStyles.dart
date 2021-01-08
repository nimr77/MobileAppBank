import 'package:flutter/material.dart';

class MyStyles {
  static Color myButton1Color = fromHex('#00d368');
  static Color myButton2Color = fromHex('#00aae1');
  static List<Color> myButtonGradient = [myButton1Color, myButton2Color];
  static List<Color> myHomePagePinkGradColors = [
    Color.fromRGBO(29, 44, 55, 1),
    Color.fromRGBO(43, 52, 58, 1)
  ];
  static LinearGradient getHomeGradientColor() => LinearGradient(
      begin: FractionalOffset.bottomLeft,
      end: FractionalOffset.topRight,
      colors: myHomePagePinkGradColors,
      stops: [0.2, 0.8]);
  static LinearGradient getButtonGradientColor() => LinearGradient(
      begin: FractionalOffset.bottomLeft,
      end: FractionalOffset.topRight,
      colors: myButtonGradient,
      stops: [0.2, 0.8]);
  static LinearGradient myTextViewGradient() => LinearGradient(
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter,
      colors: _myTextViewColors,
      stops: [-1, 0.3]);
  static List<Color> _myTextViewColors = [
    Color.fromRGBO(255, 255, 255, 0),
    Color.fromRGBO(0, 0, 0, 0.4),
  ];

  static Color myIconStyle = Color.fromRGBO(236, 197, 66, 1);

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
