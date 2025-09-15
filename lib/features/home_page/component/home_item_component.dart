import 'package:flutter/material.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';

class HomeItemComponent extends StatelessWidget {
final IconData iconData;
final String title;
final VoidCallback onTap;
  const HomeItemComponent({super.key, required this.iconData, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: screenHeight(context)*0.25,
          width: screenWidth(context)*0.35,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Icon(iconData,size: 50,color: mainColor2,)),
                  Text(title,style: Theme.of(context).textTheme.titleSmall,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
