import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

abstract class IPrefs {
  Future<void> clear();

  Future<void> setPos(int value);
  Future<int> getPos();

  Future<void> setAuth(bool value);
  Future<bool> getAuth();

  Future<void> setTheme(bool value);
  Future<bool> getTheme();

  Future<void> setOwner(String value);
  Future<String> getOwner();
}

class Prefs implements IPrefs {
  final SharedPreferences shared;

  Prefs(this.shared);

  @override
  Future<void> clear() => shared.clear();

  // POS
  @override
  Future<void> setPos(int value) => Future.value(value) //
      .then((_) => shared.setInt('pos', _))
      .then(logData('Prefs: setPos: value: $value'));

  @override
  Future<int> getPos() => Future.value(0) //
      .then((_) => shared.getInt('pos') ?? _)
      .then(logData('Prefs.getPos: '));

  // AUTH
  @override
  Future<void> setAuth(bool value) => Future.value(value) //
      .then((_) => shared.setBool('auth', _))
      .then(logData('Prefs.setAuth: value: $value'));

  @override
  Future<bool> getAuth() => Future.value(false) //
      .then((_) => shared.getBool('auth') ?? _)
      .then(logData('Prefs.getAuth: '));

  // THEME
  @override
  Future<void> setTheme(bool value) => Future.value(value) //
      .then((_) => shared.setBool('theme', _))
      .then(logData('Prefs.setTheme: value: $value'));

  @override
  Future<bool> getTheme() => Future.value(false) //
      .then((_) => shared.getBool('theme') ?? _)
      .then(logData('Prefs.getTheme: '));

  // Owner
  @override
  Future<void> setOwner(String value) => Future.value(value) //
      .then((_) => shared.setString('owner', _))
      .then(logData('Prefs.setOwner: value: $value'));

  @override
  Future<String> getOwner() => Future.value('') //
      .then((_) => shared.getString('owner') ?? _)
      .then(logData('Prefs.getOwner: '));

  // Util
  T Function(T) logData<T>(String tag) => (t) {
        log('[logData] $tag: $t');
        return t;
      };
}
