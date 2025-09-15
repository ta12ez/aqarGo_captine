import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/buttom_component.dart';
import 'package:manzal_office/core/component/navigator.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/core/network/remote/apis_const.dart';
import 'package:manzal_office/features/request/component/request_buttom.dart';
import 'package:manzal_office/features/request/controller/request_cubit.dart';
import 'package:manzal_office/features/request/models/request_model.dart';
import 'package:manzal_office/features/request_details/request_details.dart';

class RequestItemComponent extends StatelessWidget {
   RequestItemComponent({super.key,required this.pendingRequest});
   PendingRequest pendingRequest;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestCubit, RequestState>(
  builder: (context, state) {
    var cubit = RequestCubit.get(context);
    return InkWell(
      onTap: (){navigatTo(context: context, page: RequestDetailPage(pendingRequest: pendingRequest,));},
      child: Container(
        width: double.infinity,
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
                  pendingRequest.images.isEmpty?
                  Container(
                    height: screenHeight(context) * 0.25,
                    width: screenWidth(context) * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                    child: Icon(
                      Icons.broken_image,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ):
                  Container(
                    height: screenHeight(context) * 0.25,
                    width: screenWidth(context) * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage("${ApiConstance.basUrlImage}${pendingRequest.images[0]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: mainColor2
                      ),
                      padding: EdgeInsets.symmetric(vertical: screenHeight(context)*0.02,horizontal: screenWidth(context)*0.02),
                      child: Text("${pendingRequest.propertyType}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: whitColor),),
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
                      Text("${pendingRequest.title}",style: Theme.of(context).textTheme.titleSmall,maxLines: 1,overflow: TextOverflow.ellipsis,),
                      SizedBox(height: screenHeight(context)*0.01,),
                      Text("${pendingRequest.descriptionProperty}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: mainColor2),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      SizedBox(height: screenHeight(context)*0.01,),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,color: mainColor2,size: 15,),
                          SizedBox(width: screenWidth(context)*0.01,),
                          Text("${pendingRequest.stateName}, ${pendingRequest.regionName}",style: Theme.of(context).textTheme.bodySmall?.copyWith(color: mainColor2),maxLines: 1,overflow: TextOverflow.ellipsis,)
                        ],
                      ),
                      SizedBox(height: screenHeight(context)*0.01,),

                      Row(
                        children: [
                          Text('\$ ${pendingRequest.price}',style: Theme.of(context).textTheme.bodyLarge,maxLines: 1,overflow: TextOverflow.ellipsis,),
                          pendingRequest.contractType == "rent"?
                          Text('/month',style: Theme.of(context).textTheme.bodyMedium,maxLines: 1,overflow: TextOverflow.ellipsis,):
                          SizedBox(),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: screenWidth(context)*0.01,),
                          RequestButtom(text: 'delete',icon: Icons.delete_outline,color: Colors.red,onPressed:(){
                           // cubit.changeRequestStatus(id: pendingRequest.requestId, status: "rejected");
                            cubit.rejectRequest(officePropertyId: pendingRequest.requestId);
                          },),
                          Spacer(),
                          RequestButtom(text: 'accept',icon: Icons.check,onPressed:(){
                           // cubit.changeRequestStatus(id: pendingRequest.requestId, status: "accepted");
                            cubit.acceptRequest(officePropertyId: pendingRequest.requestId);
                          },),
                          SizedBox(width: screenWidth(context)*0.01,),
                        ],
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
