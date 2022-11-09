import 'package:aula13_miscelaneous/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  final txtPlayerAnimationValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<SharedPreferencesService>(
          builder: (context, sharedPreferences, child) {
        return Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: txtPlayerAnimationValue,
                  decoration: InputDecoration(
                    label: Text(
                      "Animação nº: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    int? parsed = int.tryParse(value.toString());
                    if (parsed != null) {
                      sharedPreferences.setPlayerAnimation = parsed;
                      txtPlayerAnimationValue.text = parsed.toString();
                    }
                  },
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                ),
              ),
            ),
            Text("Atual: ${sharedPreferences.getPlayerAnimation}")
          ],
          
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Provider.of<SharedPreferencesService>(context, listen: false).save();

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Salvo cadastrado com sucesso")));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.save),
      ),
    );
  }
}
