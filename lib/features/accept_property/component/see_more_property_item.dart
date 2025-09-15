import 'package:flutter/material.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/core/network/remote/apis_const.dart';
import 'package:manzal_office/features/accept_property/controller/accept_property_cubit.dart';
import 'package:manzal_office/features/accept_property/model/accept_property_model.dart';
import 'package:manzal_office/features/accept_property_detiales/accept_property_detailes_screen.dart';

import '../../../core/component/navigator.dart';
class SeeMorePropertyItem extends StatelessWidget {
 final AcceptPropertyModel acceptPropertyModel;
  const SeeMorePropertyItem({super.key, required this.acceptPropertyModel});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()async{
        AcceptPropertyCubit cubit =AcceptPropertyCubit.get(context);
        final response=await Navigator.push(context, MaterialPageRoute(builder: (context)=>AcceptPropertyDetailesScreen(property: acceptPropertyModel)));
        if(response==true){
          cubit.getAcceptProperty();
        }
      },
      child: Container(
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
                        image: NetworkImage(ApiConstance.urlImage(acceptPropertyModel.images.first)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 5,
                  //   right: 5,
                  //   child: InkWell(
                  //     onTap: () {},
                  //     child: CircleAvatar(
                  //       radius: 15,
                  //       backgroundColor: cardColor,
                  //       child: Icon(
                  //         Icons.delete_outline,
                  //         color: Colors.red,
                  //         size: 15,
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                      child: Text("${acceptPropertyModel.propertyType}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: whitColor),),
                    ),
                  ),
                ],
              ),
              Text("${acceptPropertyModel.title}",style: Theme.of(context).textTheme.bodyMedium,maxLines: 2,overflow: TextOverflow.ellipsis,),
              Row(
                children: [
                  // Icon(Icons.star,color: Colors.amber,size: 15,),
                  // SizedBox(width: screenWidth(context)*0.01,),
                  // Text("4.5",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: mainColor2),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  // SizedBox(width: 10,),
                  Icon(Icons.location_on_outlined,color: mainColor2,size: 15,),
                  SizedBox(width: screenWidth(context)*0.01,),
                  Expanded(child: Text("${acceptPropertyModel.region?.state?.name}/${acceptPropertyModel.region?.name}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: mainColor2),maxLines: 1,overflow: TextOverflow.ellipsis,))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
