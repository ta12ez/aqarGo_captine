import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/circle_icon.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/features/accept_property/component/see_more_property_item.dart';
import 'package:manzal_office/features/accept_property/controller/accept_property_cubit.dart';
import 'package:manzal_office/features/accept_property/model/accept_property_model.dart';

class SeeMoreProperty extends StatelessWidget {
  String type;
  AcceptPropertyCubit cubit;
   SeeMoreProperty({super.key,required this.cubit,required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
  value: cubit,
  child: Scaffold(
      appBar: AppBar(
        title: Text("property",style: Theme.of(context).textTheme.titleSmall,),
        leading:  Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleIcon(
            icon: Icons.arrow_back_ios_new_rounded,
            iconOnTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            BlocBuilder<AcceptPropertyCubit, AcceptPropertyState>(

  builder: (context, state) {
    List<AcceptPropertyModel>? accepted;
    if(state is GetAcceptPropertyLoadingState){
      return Center(child: CircularProgressIndicator(color: mainColor1,),);
    }else if(type=="Residential"){
       accepted = cubit.residentalProperties;
    } else if(type=="Agricultural"){
      accepted = cubit.agriculturalProperties;
    }else if(type=="Commercial"){
      print(cubit.commercialProperties?.first.propertyId);
      accepted = cubit.commercialProperties;
    }else if(type=="industrial"){
      accepted = cubit.industrialProperties;
    }
    if(accepted !=null&&accepted.isNotEmpty){
      return Expanded(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 7,
          mainAxisSpacing: 7,
          children: List.generate(accepted.length, (index) {
            return Container(
                child:SeeMorePropertyItem(acceptPropertyModel: accepted![index],));
          }),
        ),
      );
    }else{
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: mainColor2,
              size: 40,
            ),
            const SizedBox(height: 10),
            Text(
              "Check Your Connection",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: mainColor2),
            ),
          ],
        ),
      );
    }

  },
),
          ],
        ),
      ),
    ),
);
  }
}
