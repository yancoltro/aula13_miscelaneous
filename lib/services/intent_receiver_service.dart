import 'dart:async';
import 'dart:io';

import 'package:aula13_miscelaneous/components/audio_component.dart';
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
    print("********************************************************************* FILE ********************************************************************* ");
    print(intentData);
    if (intentData["type"] == "audio") {
      return Audio(intentData["file"]);
    }
    // else if(intentData["type"] == "image"){
    //   Audio(intentData["file"]);
    // } else if(intentData["type"] == "audio"){
    //   Audio(intentData["file"]);
    // }
    else {
      return CircularProgressIndicator();
    }

    return CircularProgressIndicator();
  }

  // Widget _image() {}

  // Widget _video() {}
}
