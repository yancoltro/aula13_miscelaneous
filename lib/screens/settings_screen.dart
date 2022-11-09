import 'package:aula13_miscelaneous/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  final txtPlayerAnimationValue = TextEditingController();

  final Map<String, String> animations = {
    "Pepe Pepe": "https://media.tenor.com/SexsGMnqLn0AAAAi/pepe-pepe-song.gif",
    "Meme": "https://media.tenor.com/PPj99tSSDagAAAAi/meme.gif",
    "Kirby Cute": "https://media.tenor.com/NnzehrExkuYAAAAi/kirby-cute.gif",
    "Kirby Dance": "https://media.tenor.com/0HNbCY6fuOIAAAAi/kirby-dancing.gif",
    "Ricardo Milos":
        "https://media.tenor.com/yEzLZkjI7rIAAAAi/ricardo-milos-dance.gif",
    "PewDiePie": "https://media.tenor.com/xszxWpwugmMAAAAi/pewdiepie-head.gif",
    "Mic Up": "https://media.tenor.com/7XaT1EmNrQMAAAAi/mic-upp-kid.gif",
    "HeadBang": "https://media.tenor.com/VhzxjfosSLQAAAAi/yes-headbang.gif",
    "Yikes Jam":
        "https://media.tenor.com/cbYHaBeHqhUAAAAi/yikes-jam-pepe-jam.gif",
    "Bob": "https://media.tenor.com/a4fBZzWeH30AAAAi/bob-dab.gif",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<SharedPreferencesService>(
          builder: (context, sharedPreferences, child) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: TextField(
              //       controller: txtPlayerAnimationValue,
              //       decoration: InputDecoration(
              //         label: Text(
              //           "Animação nº: ",
              //           style:
              //               TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              //         ),
              //       ),
              //       keyboardType: TextInputType.number,
              //       onChanged: (value) {
              //         int? parsed = int.tryParse(value.toString());
              //         if (parsed != null) {
              //           sharedPreferences.setPlayerAnimation = parsed;
              //           txtPlayerAnimationValue.text = parsed.toString();
              //         }
              //       },
              //       onEditingComplete: () => FocusScope.of(context).unfocus(),
              //     ),
              //   ),
              // ),
              Text(
                "Animação do Player",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                  isExpanded: true,
                  value: sharedPreferences.getPlayerAnimation,
                  items: animations
                      .map((key, value) {
                        return MapEntry(
                            key,
                            DropdownMenuItem<String>(
                              value: value,
                              child: Text(key),
                            ));
                      })
                      .values
                      .toList(),
                  onChanged: (_value) {
                    sharedPreferences.setPlayerAnimation = _value!;
                  }),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Provider.of<SharedPreferencesService>(context, listen: false).save();
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Salvo cadastrado com sucesso")));
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
