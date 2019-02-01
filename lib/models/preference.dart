import 'package:CUValles/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  @required
  bool _push;
  @required
  bool _synchronization;
  @required
  bool _syncUsesMobileNetwork;

  SharedPreferences _preferences;

  void setPush(bool value) async {
    _push = value;
    _preferences.setBool(PUSH_KEY, value);
  }

  void setSynchronization(bool value) async {
    _synchronization = value;
    _preferences.setBool(SYNCHRONIZATION_KEY, value);
  }

  void setUsesMobileNetwork(bool value) {
    _synchronization = value;
    _preferences.setBool(USES_MOBILE_NETWORK_KEY, value);
  }

  bool get push => _push ?? true;
  bool get synchronization => _synchronization ?? true;
  bool get syncUsesMobileNetwork => _syncUsesMobileNetwork ?? true;

  Preference(this._push, this._synchronization, this._syncUsesMobileNetwork, this._preferences);

  static Future getIstance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool push = preferences.getBool(PUSH_KEY) ?? true;
    bool synchronization = preferences.getBool(SYNCHRONIZATION_KEY) ?? true;
    bool syncUsesMobileNetwork = preferences.getBool(USES_MOBILE_NETWORK_KEY) ?? true;

    return Preference(push, synchronization, syncUsesMobileNetwork, preferences);
  }
}