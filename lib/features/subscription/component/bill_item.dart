import 'package:flutter/material.dart';
import 'package:manzal_office/core/constant/color.dart';

class BillItem extends StatelessWidget {
 final IconData? iconData;
 final String firstText;
 final String secondText;
  const BillItem({super.key, this.iconData, required this.firstText, required this.secondText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          if(iconData!=null)
          Icon(iconData,size: 25,color: mainColor2,),
          if(iconData!=null)
            SizedBox(width: 5,),
          Expanded(child: Text(firstText,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainColor2))),

          Text(secondText,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green),)
        ],
      ),
    );
  }
}
