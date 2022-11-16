// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherScreen extends StatefulWidget {
  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  bool _hasCallSupport = false;
  Future<void>? _launched;
  String _phone = '';
  String _email = '';
  String _subject = '';
  String _emailBody = '';
  String _smsBody = 'Olá, essa é uma mensagem padrão';

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  // Future<void> _launchInWebViewWithoutJavaScript(Uri url) async {
  //   if (!await launchUrl(
  //     url,
  //     mode: LaunchMode.inAppWebView,
  //     webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
  //   )) {
  //     throw 'Could not launch $url';
  //   }
  // }

  // Future<void> _launchInWebViewWithoutDomStorage(Uri url) async {
  //   if (!await launchUrl(
  //     url,
  //     mode: LaunchMode.inAppWebView,
  //     webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
  //   )) {
  //     throw 'Could not launch $url';
  //   }
  // }

  Future<void> _launchUniversalLinkIos(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> _makePhoneCall(String scheme) async {
    final Uri launchUri = Uri(
      scheme: scheme, // tel | sms
      path: _phone,
      queryParameters: {"body": _smsBody}
    );
    await launchUrl(launchUri);
  }

  Future<void> _makeEmail() async {
    final Uri launchUri = Uri(
        scheme: 'mailto',
        path: _email,
        queryParameters: {"subject": _subject, "body": _emailBody});
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    // onPressed calls using this URL are not gated on a 'canLaunch' check
    // because the assumption is that every device can launch a web URL.
    final Uri toLaunch =
        Uri(scheme: 'https', host: 'www.cylog.org', path: 'headers/');
    return Scaffold(
      appBar: AppBar(
        title: Text("URL Launcher"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                    onChanged: (String text) => _phone = text,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        hintText: 'Insira o telefone')),
              ),
               Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                    onChanged: (String text) => _smsBody = text,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'Caso SMS, digite o corpo')),
              ),
              ElevatedButton(
                onPressed: _hasCallSupport
                    ? () => setState(() {
                          _launched = _makePhoneCall("tel");
                        })
                    : null,
                child: _hasCallSupport
                    ? const Text('Fazer chamada')
                    : const Text('Sem suporte para chamadas'),
              ),
              ElevatedButton(
                onPressed: _hasCallSupport
                    ? () => setState(() {
                          _launched = _makePhoneCall("sms");
                        })
                    : null,
                child: const Text('Enviar SMS'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                    onChanged: (String text) => _email = text,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'Insira o endereço de email')),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                    onChanged: (String text) => _subject = text,
                    keyboardType: TextInputType.text,
                    decoration:
                        const InputDecoration(hintText: 'Insira o assunto')),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                    onChanged: (String text) => _emailBody = text,
                    keyboardType: TextInputType.text,
                    decoration:
                        const InputDecoration(hintText: 'Insira o corpo')),
              ),
              ElevatedButton(
                  onPressed: _hasCallSupport
                      ? () => setState(() {
                            _launched = _makeEmail();
                          })
                      : null,
                  child: const Text('Enviar email')),

              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(toLaunch.toString()),
              ),

              ElevatedButton(
                onPressed: () => setState(() {
                  _launched = _launchInBrowser(toLaunch);
                }),
                child: const Text('Abrir no browser'),
              ),
              const Padding(padding: EdgeInsets.all(16.0)),
              ElevatedButton(
                onPressed: () => setState(() {
                  _launched = _launchInWebViewOrVC(toLaunch);
                }),
                child: const Text('Abrir no app'),
              ),
              // ElevatedButton(
              //   onPressed: () => setState(() {
              //     _launched = _launchInWebViewWithoutJavaScript(toLaunch);
              //   }),
              //   child: const Text('Abrir no app (JavaScript OFF)'),
              // ),
              // ElevatedButton(
              //   onPressed: () => setState(() {
              //     _launched = _launchInWebViewWithoutDomStorage(toLaunch);
              //   }),
              //   child: const Text('Abrir no app (DOM storage OFF)'),
              // ),
              const Padding(padding: EdgeInsets.all(16.0)),
              // ElevatedButton(
              //   onPressed: () => setState(() {
              //     _launched = _launchUniversalLinkIos(toLaunch);
              //   }),
              //   child: const Text(
              //       'Launch a universal link in a native app, fallback to Safari.(Youtube)'),
              // ),
              const Padding(padding: EdgeInsets.all(16.0)),
              ElevatedButton(
                onPressed: () => setState(() {
                  _launched = _launchInWebViewOrVC(toLaunch);
                  Timer(const Duration(seconds: 5), () {
                    print('Closing WebView after 5 seconds...');
                    closeInAppWebView();
                  });
                }),
                child: const Text('Abrir no app (fechar depois de 5 segundos)'),
              ),
              const Padding(padding: EdgeInsets.all(16.0)),
              // Link(
              //   uri: Uri.parse(
              //       'https://pub.dev/documentation/url_launcher/latest/link/link-library.html'),
              //   target: LinkTarget.blank,
              //   builder: (BuildContext ctx, FollowLink? openLink) {
              //     return TextButton.icon(
              //       onPressed: openLink,
              //       label: const Text('Link Widget documentation'),
              //       icon: const Icon(Icons.read_more),
              //     );
              //   },
              // ),
              const Padding(padding: EdgeInsets.all(16.0)),
              FutureBuilder<void>(future: _launched, builder: _launchStatus),
            ],
          ),
        ],
      ),
    );
  }
}
