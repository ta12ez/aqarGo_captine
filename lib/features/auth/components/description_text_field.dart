import 'package:flutter/material.dart';
import 'package:manzal_office/core/constant/color.dart';

class DescriptionResizableField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const DescriptionResizableField({
    super.key,
    required this.controller,
    this.hintText = 'Description',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 100,
          maxHeight: 300,
        ),
        child: Scrollbar(
          child: TextFormField(
            controller: controller,
            cursorColor: foucosColor,
            maxLines: null, // للسماح بالتمدد
            keyboardType: TextInputType.multiline,
            style: TextStyle(color: blackColor),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              border: InputBorder.none,
              prefixIcon: Icon(Icons.description_outlined),
            ),
          ),
        ),
      ),
    );
  }
}
