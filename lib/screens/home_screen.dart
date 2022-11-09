import 'package:aula13_miscelaneous/models/custom_notification_model.dart';
import 'package:aula13_miscelaneous/services/intent_receiver_service.dart';
import 'package:aula13_miscelaneous/services/notification_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget itentWidget = Text("Carregando...");
  IntentReceiverService intentService = IntentReceiverService();
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    _initState();
    super.initState();
  }

  _initState() async {
    if (!mounted) return;
    await intentService.checkForIntent();
    Widget _widget = await intentService.getVisualComponent();
    setState(() {
      itentWidget = _widget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intents'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 50),
              child: itentWidget,
            ),
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
                      payload: "String")),
              child: Text("Agendar notificação"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/settings"),
        child: const Icon(Icons.settings),
      ),
    );
  }
}
