import 'package:flutter/material.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/features/profile/component/divader_component.dart';

class SettingItem extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Color titleColor;

  final String title;
 final void Function()? onTap;
  const SettingItem({super.key, required this.iconData, required this.title,  this.onTap,  this.iconColor = mainColor2,  this.titleColor =mainColor2});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Icon(iconData,color: iconColor,size: 25,),
            SizedBox(width: 5,),
            Text("$title",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: titleColor),),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded,color: iconColor,size: 25,),
          ],
        ),
      ),
    );
  }
}
