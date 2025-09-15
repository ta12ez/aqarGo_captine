import 'package:flutter/material.dart';
import 'package:manzal_office/core/constant/color.dart';

class ProfileItem extends StatelessWidget {
 final IconData iconData;
 final String title;
 final String text;

  const ProfileItem({super.key, required this.iconData, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(iconData,color: mainColor2,size: 25,),
          SizedBox(width: 5,),
          Text("$title:",style: Theme.of(context).textTheme.titleSmall,),
          SizedBox(width: 5,),
          Expanded(child: Text(text,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainColor2),)),
        ],
      ),
    );
  }
}
