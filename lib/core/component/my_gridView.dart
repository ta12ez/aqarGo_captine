import 'package:flutter/material.dart';


class MyGridview extends StatelessWidget {
  const MyGridview({super.key, required this.widget});
   final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 7,
        mainAxisSpacing: 7,
        children: List.generate(10, (index) {
          return Container(
              child:widget);
        }),
      ),
    );
  }
}
