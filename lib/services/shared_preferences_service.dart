import 'package:aula13_miscelaneous/models/preferences_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService extends ChangeNotifier {
  late Preferences preferences;
  late SharedPreferences sharedPreferences;

  SharedPreferencesService() {
    preferences = new Preferences();
    _init();
    _load();
  }

  _init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  _load() async {
    preferences.setPlayerAnimation =
        await sharedPreferences.getInt('playerAnimation') ?? 0;
  }

  save() async {
    await sharedPreferences.setInt(
        'playerAnimation', preferences.getPlayerAnimation);
  }

  void set playerAnimation(int value) {
    preferences.setPlayerAnimation = value;
    notifyListeners();
  }
}
