import 'package:flutter/material.dart';

abstract class ThemeEvent{

}

class GetThemeEvent extends ThemeEvent{

}

class ToggleThemeEvent extends ThemeEvent{

}

class ToggleThemeWithValueEvent extends ThemeEvent{
  final ThemeMode themeMode;
  ToggleThemeWithValueEvent(this.themeMode);
}