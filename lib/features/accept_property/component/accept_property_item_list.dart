import 'package:flutter/material.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/accept_property/component/accept_property_card_component.dart';
import 'package:manzal_office/features/accept_property/model/accept_property_model.dart';

class AcceptPropertyItemList extends StatelessWidget {
  List<AcceptPropertyModel>? properties;

  AcceptPropertyItemList({super.key,required this.properties});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context)*0.25,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => AcceptPropertyItemCardComponent(property: properties![index],),
        separatorBuilder:
            (context, index) => SizedBox(width: screenWidth(context)*0.05),
        itemCount: properties!.length,
      ),
    );
  }
}
