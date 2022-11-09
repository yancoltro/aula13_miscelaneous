import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart' hide Intent;
import 'package:receive_intent/receive_intent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uri_to_file/uri_to_file.dart';
import 'package:share_plus/share_plus.dart';

class IntentReceiverService{

 Future<void> checkForIntent() async {
    final receivedIntent = await ReceiveIntent.getInitialIntent();

    if (!mounted) return;

    Widget _resolved = await _decideShow(receivedIntent!);

    setState(() {
      // _initialIntent = receivedIntent!;
      _toShow = _resolved;
    });
  }

 
}