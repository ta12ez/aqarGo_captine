import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/buttom_component.dart';
import 'package:manzal_office/core/component/circle_icon.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/accept_property/model/accept_property_model.dart';
import 'package:manzal_office/features/accept_property_detiales/component/atribute_component.dart';
import 'package:manzal_office/features/accept_property_detiales/component/images_page_view_component.dart';
import 'package:manzal_office/features/accept_property_detiales/controller/accept_property_details_cubit.dart';

import '../../core/component/dialog_component.dart';

class AcceptPropertyDetailesScreen extends StatelessWidget {
  AcceptPropertyModel property;
  AcceptPropertyDetailesScreen({super.key,required this.property});
  final List<String> images = [
    'assets/images/test.png',
    'assets/images/test1.jpg',
    'assets/images/test2.jpg',
    'assets/images/test3.jpg',
    'assets/images/testt.png',
    'assets/images/test.png',
  ];
 // PendingRequests pendingRequest;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AcceptPropertyDetailsCubit(),
      child: Scaffold(
        body: BlocConsumer<AcceptPropertyDetailsCubit, AcceptPropertyDetailsState>(
            listener: (context,state){
              if(state is AddADSPropertySuccessState||state is DeletePropertySuccessState){
                Navigator.pop(context,true);
              }
            },
          builder: (context, state) {

            AcceptPropertyDetailsCubit cubite=AcceptPropertyDetailsCubit.get(context);

            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ImagesPageViewComponent(images: property.images,propertyType: property.propertyType??'',),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 10,vertical:20 ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${property.title}',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: mainColor2),overflow: TextOverflow.ellipsis,maxLines: 2,),
                                SizedBox(height: screenHeight(context)*0.02,),
                                Text('${property.descriptionProperty}',
                                  style: Theme.of(context).textTheme.bodyMedium,),

                                SizedBox(height: screenHeight(context)*0.05,),
                                AtributeComponent(icon: Icons.location_on, title: 'location', text: '${property.region?.state?.name}, ${property.region?.name}',),
                                SizedBox(height: screenHeight(context)*0.01,),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,color: mainColor2,size: 15,),
                                    SizedBox(width: 5,),
                                    Text('location description:',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainColor2),),
                                  ],
                                ),
                                SizedBox(height: screenHeight(context)*0.01,),
                                Text('${property.descriptionLocation}',style: Theme.of(context).textTheme.bodyMedium,),
                                SizedBox(height: screenHeight(context)*0.01,),
                                Divider(),
                                SizedBox(height: screenHeight(context)*0.01,),

                                AtributeComponent(icon: Icons.person, title: 'owner', text: '${property.user?.firstName} ${property.user?.lastName}',),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.phone,color: mainColor2,size: 15,),
                                          SizedBox(width: 5,),
                                          Text('phone:',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainColor2),),
                                          Spacer(),
                                          Text('${property.user?.phone}',style: Theme.of(context).textTheme.bodyMedium ,),
                                          SizedBox(width: 5,),
                                          CircleIcon(iconOnTap: (){
                                            cubite.makePhoneCall('${property.user?.phone}');
                                          },icon: Icons.phone,),
                                        ],),
                                      Divider(),
                                    ],
                                  ),
                                ),
                                AtributeComponent(icon: Icons.add_box_outlined, title: 'contract Type', text: '${property.contractType}',),
                                property.contractType == "rent"?
                                AtributeComponent(icon: Icons.monetization_on_outlined, title: 'price', text: '${property.price}\$ /per month ',):
                                AtributeComponent(icon: Icons.monetization_on_outlined, title: 'price', text: '${property.price}\$',),
                                AtributeComponent(icon: Icons.map_outlined, title: 'space', text: '${property.space} /m^2',),
                                SizedBox(height: screenHeight(context)*0.02,),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight(context)*0.02,),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ButtomComponent(text: 'make it spacial',icon: Icons.add_business_sharp,onPressed:(){
                  //     showDialog(context: context,
                  //         builder:(context)=>DialogComponent(
                  //           confirmText: "yes",
                  //           cancelText: "no",
                  //           title: "Make It Special",
                  //           content: "سيتم إضافة الإعلان إلى الإعلانات المميزة بتكلفة 5 نقاط. هل ترغب بالمتابعة",
                  //           onConfirm: (){},
                  //         ));
                  //
                  //   },),
                  // ),
                  // SizedBox(height: screenHeight(context)*0.02,),

                  Row(
                    children: [
                      Expanded(
                        child:state is AddADSPropertyLoadingState? Container(child: Center(child: CircularProgressIndicator(color: mainColor1,),),):ButtomComponent(text: 'make it spacial',icon: Icons.add_business_sharp,onPressed:(){

                            showDialog(context: context,
                                builder:(context)=>DialogComponent(
                                  confirmText: "yes",
                                  cancelText: "no",
                                  title: "Make It Special",
                                  content: "سيتم إضافة الإعلان إلى الإعلانات المميزة بتكلفة 5 نقاط. هل ترغب بالمتابعة",
                                  onConfirm: (){cubite.addAdvert(id:property.pivot!.id! );},
                                ));


                        },),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child:state is DeletePropertyLoadingState? Container(child: Center(child: CircularProgressIndicator(color: mainColor1,),),): ButtomComponent(text: 'delete',icon: Icons.delete_outline,color: Colors.red,onPressed:(){
                          showDialog(context: context, builder: (context)=>DialogComponent(
                            confirmText: "yes",
                            confirmColor: Colors.red,
                            cancelText: "no",
                            title: "Delete",
                            content: "do you want to delete",
                            onConfirm: (){cubite.deleteProperty(id: property.pivot!.id!);},
                          ));

                          // cubite.changeRequestStatus(id: property.requestId, status: "rejected",context: context);
                        },),
                      ),
                    ],
                  ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
