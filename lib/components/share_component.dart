import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButtonTheme(
          data: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(minimumSize: Size(360, 60))),
          child: ButtonBar(
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                onPressed: () => Share.shareXFiles([XFile(file.path)],
                    text: "Compartilhando com nosso App", subject: "Subject"),
                child: Icon(Icons.share),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
