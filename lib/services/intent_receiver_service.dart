import 'dart:async';
import 'dart:io';

import 'package:aula13_miscelaneous/models/intent_receiver_model.dart';
import 'package:flutter/material.dart' hide Intent;
import 'package:receive_intent/receive_intent.dart';

class IntentReceiverService {
  late IntentReceiverModel? intentReceiver;

  Future<void> checkForIntent() async {
    final receivedIntent = await ReceiveIntent.getInitialIntent();
    if (receivedIntent != null) {
      intentReceiver = IntentReceiverModel(
        fromPackageName: receivedIntent!.fromPackageName,
        fromSignatures: receivedIntent!.fromSignatures,
        action: receivedIntent!.action,
        data: receivedIntent!.data,
        extra: receivedIntent!.extra,
      );
    }
  }

  Widget getVisualComponent(){
    return Center();
  }

  Widget _audio(){
    
  }

  Widget _image(){
    
  }

  Widget _video(){
    
  }
}
