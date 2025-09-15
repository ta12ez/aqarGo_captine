import 'package:flutter/material.dart';
import 'package:manzal_office/core/constant/color.dart';

class AtributeComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const AtributeComponent({super.key, required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon,color: mainColor2,size: 15,),
              SizedBox(width: 5,),
              Text('${title}:',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainColor2),),
              Spacer(),
              Text(text,style: Theme.of(context).textTheme.bodyMedium ,),
            ],),
          Divider(),
        ],
      ),
    );
  }
}
