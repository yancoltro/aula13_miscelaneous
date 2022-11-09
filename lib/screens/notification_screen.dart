import 'package:aula13_miscelaneous/models/custom_notification_model.dart';
import 'package:aula13_miscelaneous/services/intent_receiver_service.dart';
import 'package:aula13_miscelaneous/services/notification_service.dart';
import 'package:aula13_miscelaneous/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {

  NotificationService notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedPreferencesService>(
        builder: (context, sharedPrefereces, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => notificationService.showNotification(
                      CustomNotification(
                          id: 1,
                          title: "Notificação Miscelaneous",
                          body: "Esta é uma notificação",
                          payload: "String")),
                  child: Text("Notificar agora"),
                ),
                ElevatedButton(
                  onPressed: () => notificationService.scheduleNotification(
                      CustomNotification(
                          id: 1,
                          title: "Notificação Miscelaneous",
                          body: "Esta é uma notificação Agendada",
                          payload: "String"), sharedPrefereces.getNotificationSeconds),
                  child: Text("Agendar notificação"),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, "/settings"),
          child: const Icon(Icons.settings),
        ),
      );
    });
  }
}
