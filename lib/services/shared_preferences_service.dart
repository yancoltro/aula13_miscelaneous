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
        await sharedPreferences.getString('playerAnimation') ?? "https://media.tenor.com/SexsGMnqLn0AAAAi/pepe-pepe-song.gif";
  }

  save() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        'playerAnimation', _preferences.getPlayerAnimation);
  }

  void set setPlayerAnimation(String value) {
    _preferences.setPlayerAnimation = value;
    notifyListeners();
  }

  String get getPlayerAnimation => _preferences.getPlayerAnimation;
}
