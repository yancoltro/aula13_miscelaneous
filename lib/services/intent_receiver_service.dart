import 'dart:async';

import 'package:aula13_miscelaneous/components/audio_component.dart';
import 'package:aula13_miscelaneous/components/image_component.dart';
import 'package:aula13_miscelaneous/models/intent_receiver_model.dart';
import 'package:flutter/material.dart' hide Intent;
import 'package:receive_intent/receive_intent.dart';

class IntentReceiverService {
  late IntentReceiverModel? intentReceiver;

  Future<void> checkForIntent() async {
    final receivedIntent = await ReceiveIntent.getInitialIntent();
    if (receivedIntent != null) {
      intentReceiver = IntentReceiverModel(
        fromPackageName: receivedIntent.fromPackageName,
        fromSignatures: receivedIntent.fromSignatures,
        action: receivedIntent.action,
        data: receivedIntent.data,
        extra: receivedIntent.extra,
      );
    }
  }

  Future<Widget> getVisualComponent() async {
    Map<String, dynamic> intentData = await intentReceiver!.getSource();

    if (intentData["type"] == "audio") {
      return AudioComponent(intentData["file"]);
    } else if (intentData["type"] == "image") {
      return ImageComponent(intentData["file"]);
    }
    //else if(intentData["type"] == "audio"){
    // TODO
    // }
    else {
      return CircularProgressIndicator();
    }
    return CircularProgressIndicator();
  }
}
