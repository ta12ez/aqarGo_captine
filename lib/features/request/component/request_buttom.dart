import 'package:flutter/material.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';

class RequestButtom extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color color;
  final VoidCallback onPressed;

  const RequestButtom({super.key, required this.text,this.icon, this.color = mainColor1, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: color,
        //shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding:  EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(icon !=null)
            Icon(icon,color: whitColor,),
          if(icon !=null)
            SizedBox(width: screenWidth(context)*0.01,),
          Text(
           text ,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
              color: Colors.white,
            ),
          ),
          if(icon !=null)
            SizedBox(width: screenWidth(context)*0.01,),


        ],
      ),
    );
  }
}
