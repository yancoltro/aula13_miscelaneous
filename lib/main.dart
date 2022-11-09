// import 'package:features_3/screens/home_screen.dart';
// import 'package:features_3/screens/intent_receiver_screen.dart';
// import 'package:features_3/screens/settings_screen.dart';
import 'package:aula13_miscelaneous/models/custom_notification_model.dart';
import 'package:aula13_miscelaneous/screens/home_screen.dart';
import 'package:aula13_miscelaneous/screens/settings_screen.dart';
import 'package:aula13_miscelaneous/services/intent_receiver_service.dart';
import 'package:aula13_miscelaneous/services/notification_service.dart';
import 'package:aula13_miscelaneous/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SharedPreferencesService())
    ], child: AppMiscelaneous()),
  );
}

class AppMiscelaneous extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Miscelaneous",
      home: HomeScreen(),
      routes: {
        // '/': (context) => HomeScreen(),
        // '/intent_receiver': (context) => IntentReceiverScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
