import 'package:flutter/material.dart';
import 'package:manzal_office/core/constant/color.dart';

class TextButtonComponent extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  const TextButtonComponent({super.key, required this.onPressed, required this.text,  this.textColor=mainColor2});

  @override
  Widget build(BuildContext context) {
    return TextButton(

      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
      ),
    );
  }
}
