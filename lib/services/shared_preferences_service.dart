import 'package:aula13_miscelaneous/models/preferences_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService extends ChangeNotifier {
  late Preferences _preferences;

  SharedPreferencesService() {
    _preferences = new Preferences();
    _load();
  }

  _load() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _preferences.setPlayerAnimation =
        await sharedPreferences.getInt('playerAnimation') ?? 0;
  }

  save() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(
        'playerAnimation', _preferences.getPlayerAnimation);
  }

  void set setPlayerAnimation(int value) {
    _preferences.setPlayerAnimation = value;
    notifyListeners();
  }

  int get getPlayerAnimation => _preferences.getPlayerAnimation;
}
