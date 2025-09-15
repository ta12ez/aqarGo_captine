import 'package:flutter/material.dart';
import 'package:manzal_office/core/component/navigator.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/core/network/remote/apis_const.dart';
import 'package:manzal_office/features/accept_property/controller/accept_property_cubit.dart';
import 'package:manzal_office/features/accept_property/model/accept_property_model.dart';
import 'package:manzal_office/features/accept_property_detiales/accept_property_detailes_screen.dart';
import 'package:manzal_office/features/edit_property/edit_property.dart';

class AcceptPropertyItemCardComponent extends StatelessWidget {
  AcceptPropertyModel property;
  AcceptPropertyItemCardComponent({super.key,required this.property});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        AcceptPropertyCubit cubit =AcceptPropertyCubit.get(context);
       final response=await Navigator.push(context, MaterialPageRoute(builder: (context)=>AcceptPropertyDetailesScreen(property: property)));
        if(response==true){
          cubit.getAcceptProperty();
        }
        },
      child: Container(
        width: screenWidth(context)*0.8,
        height: screenHeight(context)*0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    height: screenHeight(context) * 0.25,
                    width: screenWidth(context) * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(ApiConstance.urlImage(property.images.first)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 5,
                  //   left: 5,
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
                    left: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: mainColor2
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: Text("${property.propertyType}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: whitColor),),
                    ),
                  ),
                ],
              ),
              SizedBox(width: screenWidth(context)*0.02,),

              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${property.title}",style: Theme.of(context).textTheme.titleSmall,maxLines: 2,overflow: TextOverflow.ellipsis,),
                      // SizedBox(height: screenHeight(context)*0.01,),
                      // Row(
                      //   children: [
                      //     Icon(Icons.star,color: Colors.amber,size: 15,),
                      //     SizedBox(width: screenWidth(context)*0.01,),
                      //     Text("${property.}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: mainColor2),maxLines: 1,overflow: TextOverflow.ellipsis,)
                      //   ],
                      // ),
                      SizedBox(height: screenHeight(context)*0.01,),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,color: mainColor2,size: 15,),
                          SizedBox(width: screenWidth(context)*0.01,),
                          Expanded(child: Text("${property.region?.state?.name}/${property.region?.name}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: mainColor2),maxLines: 1,overflow: TextOverflow.ellipsis,))
                        ],
                      ),

                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: mainColor2
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        child: Text("${property.contractType}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: whitColor),),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Expanded(child: Text('\$ ${property.price}',style: Theme.of(context).textTheme.bodyLarge,maxLines: 1,overflow: TextOverflow.ellipsis,)),
                       if(property.contractType=="rent")
                          Text('/month',style: Theme.of(context).textTheme.bodyMedium,maxLines: 1,overflow: TextOverflow.ellipsis,),

                        ],
                      ),

                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
