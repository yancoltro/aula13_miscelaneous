import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:aula13_miscelaneous/models/intent_receiver_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class Audio extends StatefulWidget {
  final File file;
  const Audio(this.file);

  @override
  State<Audio> createState() => _AudioState(file);
}

class _AudioState extends State<Audio> {
  late File file;
  AudioPlayer audioPlayer = AudioPlayer();
  _AudioState(this.file);

  @override
  void initState() {
    _initState();
    super.initState();
  }

  void _initState() async {
    await audioPlayer.setSourceUrl(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
            "https://gifimage.net/wp-content/uploads/2017/10/music-bars-gif-3.gif"), //default
        // Image.network(playerAnimation),
        Row(
          children: [
            ElevatedButtonTheme(
              data: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(minimumSize: Size(175, 60))),
              child: ButtonBar(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                      onPressed: () => audioPlayer.pause(),
                      child: Icon(Icons.stop)),
                  ElevatedButton(
                      onPressed: () => audioPlayer.resume(),
                      child: Icon(Icons.play_arrow)),
                ],
              ),
            ),
          ],
        ),
        // Row(
        //   children: [
        //     ElevatedButtonTheme(
        //       data: ElevatedButtonThemeData(
        //           style: ElevatedButton.styleFrom(minimumSize: Size(360, 60))),
        //       child: ButtonBar(
        //         mainAxisSize: MainAxisSize.max,
        //         children: [
        //           ElevatedButton(
        //             onPressed: () => Share.shareXFiles([XFile(file.path)],
        //                 text: "Compartilhando com nosso App",
        //                 subject: "Subject"),
        //             child: Icon(Icons.share),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
