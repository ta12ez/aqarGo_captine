import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/buttom_component.dart';
import 'package:manzal_office/core/component/circle_icon.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/request/models/request_model.dart';
import 'package:manzal_office/features/request_details/component/atribute_component.dart';
import 'package:manzal_office/features/request_details/component/images_page_view_component.dart';
import 'package:manzal_office/features/request_details/controller/request_details_cubit.dart';

import '../../core/constant/app_localizations.dart';

class RequestDetailPage extends StatelessWidget {
  RequestDetailPage({super.key,required this.pendingRequest});
  PendingRequest pendingRequest;
  @override
  Widget build(BuildContext context) {
    final localizer = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    return BlocProvider(
      create: (_) => RequestDetailsCubit(),
      child: Scaffold(
        body: BlocBuilder<RequestDetailsCubit, RequestDetailsState>(
          builder: (context, state) {

            RequestDetailsCubit cubite=RequestDetailsCubit.get(context);

            return Directionality(
              textDirection:  isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ImagesPageViewComponent(images: pendingRequest.images,propertyType:localizer.translate("${pendingRequest.propertyType}") ,),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10,vertical:20 ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${pendingRequest.title}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: mainColor2),overflow: TextOverflow.ellipsis,maxLines: 2,),
                            SizedBox(height: screenHeight(context)*0.02,),
                            Text('${pendingRequest.descriptionProperty}',
                              style: Theme.of(context).textTheme.bodyMedium,),

                            SizedBox(height: screenHeight(context)*0.05,),
                            AtributeComponent(icon: Icons.location_on, title: '${localizer.translate("location")}', text: '${pendingRequest.stateName}, ${pendingRequest.regionName}',),
                            SizedBox(height: screenHeight(context)*0.01,),
                            Row(
                              children: [
                                Icon(Icons.location_on,color: mainColor2,size: 15,),
                                SizedBox(width: 5,),
                                Text('${localizer.translate("description")} ${localizer.translate("location")}:',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainColor2),),
                              ],
                            ),
                             SizedBox(height: screenHeight(context)*0.01,),
                            Text('${pendingRequest.descriptionLocation}',style: Theme.of(context).textTheme.bodyMedium,),
                            SizedBox(height: screenHeight(context)*0.01,),
                             Divider(),
                            SizedBox(height: screenHeight(context)*0.01,),

                            AtributeComponent(icon: Icons.person, title: '${localizer.translate("owner")}', text: '${pendingRequest.firstName} ${pendingRequest.lastName}',),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.phone,color: mainColor2,size: 15,),
                                  SizedBox(width: 5,),
                                  Text('${localizer.translate("phone")}:',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainColor2),),
                                  Spacer(),
                                  Text('${pendingRequest.userPhone}',style: Theme.of(context).textTheme.bodyMedium ,),
                                  SizedBox(width: 5,),
                                  CircleIcon(iconOnTap: (){
                                    cubite.makePhoneCall('${pendingRequest.userPhone}');
                                  },icon: Icons.phone,),
                                ],),
                              Divider(),
                            ],
                          ),
                        ),
                            AtributeComponent(icon: Icons.add_box_outlined, title: '${localizer.translate("contract type")}', text: '${localizer.translate("${pendingRequest.contractType}")}',),
                            pendingRequest.contractType == "rent"?
                            AtributeComponent(icon: Icons.monetization_on_outlined, title: '${localizer.translate("price")}', text: '${pendingRequest.price}\$ /${localizer.translate("per month")}',):
                            AtributeComponent(icon: Icons.monetization_on_outlined, title: '${localizer.translate("price")}', text: '${pendingRequest.price}\$',),
                            AtributeComponent(icon: Icons.map_outlined, title: '${localizer.translate("space")}', text: '${pendingRequest.space} /${localizer.translate("m")}',),
                            SizedBox(height: screenHeight(context)*0.02,),
                            Row(
                              children: [
                                ButtomComponent(text: '${localizer.translate("delete")}',icon: Icons.delete_outline,color: Colors.red,onPressed:(){
                                  //cubite.changeRequestStatus(id: pendingRequest.requestId, status: "rejected",context: context);
                                  cubite.rejectRequest(officePropertyId: pendingRequest.requestId);
                                },),
                                Spacer(),
                                ButtomComponent(text: '${localizer.translate("accept")}',icon: Icons.check,onPressed:(){
                                  print(pendingRequest.requestId);
                                  //cubite.changeRequestStatus(id: pendingRequest.requestId, status: "accepted",context: context);
                                  cubite.acceptRequest(officePropertyId: pendingRequest.requestId);
                                },)
                              ],
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
