import 'package:flutter/material.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/followers/models/followers_model.dart';

import '../../../core/network/remote/apis_const.dart';

class FollowersItem extends StatelessWidget {
   FollowersItem({super.key,required this.follower});
  Followers follower;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            follower.image == null?
            Icon(Icons.person,color: mainColor2,size: 50,):
            CircleAvatar(
              radius: 23,
              backgroundImage: NetworkImage('${ApiConstance.basUrlImage}${follower.image}'),
            ),
            SizedBox(width: screenWidth(context)*0.01,),
            Text("${follower.FirstName} ${follower.LastName}",style: Theme.of(context).textTheme.titleSmall,),
          ],
        ),
      ),
    );
  }
}
