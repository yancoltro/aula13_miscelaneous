import 'dart:io';

import 'package:aula13_miscelaneous/components/share_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageComponent extends StatelessWidget {
  final File file;
  const ImageComponent(this.file);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.file(file),
          ],
        ),
        ShareComponent(file: file),
      ],
    );
  }
}
