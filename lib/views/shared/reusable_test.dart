import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final TextStyle style;
  const ReusableText({super.key, required this.text,
    required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.fade,
      textAlign: TextAlign.left,
      softWrap: false,
      style: style,
    );
  }
}
