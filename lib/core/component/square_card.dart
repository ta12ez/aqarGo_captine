import 'package:flutter/material.dart';

import '../constant/color.dart';
import '../constant/screen_size.dart';

class SquareCard extends StatelessWidget {
  const SquareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context)*0.45,
      height: screenHeight(context)*0.30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: screenHeight(context) * 0.25,
                  width: screenWidth(context) * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage("assets/images/testt.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: cardColor,
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: mainColor1,
                        size: 15,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    height: screenHeight(context)*0.05,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor2
                    ),
                    padding: EdgeInsets.symmetric(vertical: screenHeight(context)*0.01,horizontal: screenWidth(context)*0.01),
                    child: Text("Apartment",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: whitColor),),
                  ),
                ),
              ],
            ),
            Text("SkyDandelions Apartment",style: Theme.of(context).textTheme.bodyMedium,maxLines: 2,overflow: TextOverflow.ellipsis,),
            Row(
              children: [
                Icon(Icons.star,color: Colors.amber,size: 15,),
                SizedBox(width: screenWidth(context)*0.01,),
                Text("4.5",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: mainColor2),maxLines: 1,overflow: TextOverflow.ellipsis,),
                SizedBox(width: 10,),
                Icon(Icons.location_on_outlined,color: mainColor2,size: 15,),
                SizedBox(width: screenWidth(context)*0.01,),
                Expanded(child: Text("Damascus",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: mainColor2),maxLines: 1,overflow: TextOverflow.ellipsis,))
              ],
            )
          ],
        ),
      ),
    );
  }
}
