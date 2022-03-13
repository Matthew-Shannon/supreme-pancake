import 'package:flutter/material.dart';

abstract class IStyle {
  ThemeData darkTheme();
  ThemeData lightTheme();
  ThemeData selectTheme(bool status);
}

class Style implements IStyle {
  @override
  ThemeData darkTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        toggleableActiveColor: Colors.indigoAccent,
        accentColor: Colors.indigoAccent,
      );

  @override
  ThemeData lightTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        toggleableActiveColor: Colors.indigoAccent,
        accentColor: Colors.indigoAccent,
      );

  @override
  ThemeData selectTheme(bool status) => status ? darkTheme() : lightTheme();
}
