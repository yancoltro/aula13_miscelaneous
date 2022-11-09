// // import 'package:features_3/screens/home_screen.dart';
// // import 'package:features_3/screens/intent_receiver_screen.dart';
// // import 'package:features_3/screens/settings_screen.dart';
// import 'package:aula13_miscelaneous/services/intent_receiver_service.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(AppMiscelaneous());
// }

// class AppMiscelaneous extends StatefulWidget {
//   const AppMiscelaneous({super.key});

//   @override
//   State<AppMiscelaneous> createState() => _AppMiscelaneousState();
// }

// class _AppMiscelaneousState extends State<AppMiscelaneous> {
//   late Widget itentWidget = Text("Carregando...");
//   IntentReceiverService intentService = IntentReceiverService();

//   @override
//   void initState() {
//     _initState();
//     super.initState();
//   }

//   _initState() async {
//     if (!mounted) return;
//     await intentService.checkForIntent();
//     Widget _widget = await intentService.getVisualComponent();
//     setState(() {
//       itentWidget = _widget;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Intents'),
//         ),
//         body: Center(child: itentWidget),
//       ),
//     );
//   }
// }
