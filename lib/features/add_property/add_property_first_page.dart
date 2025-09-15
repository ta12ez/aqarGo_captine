import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/buttom_component.dart';
import 'package:manzal_office/core/component/circle_icon.dart';
import 'package:manzal_office/core/component/navigator.dart';
import 'package:manzal_office/core/component/section_component.dart';
import 'package:manzal_office/core/component/text_from_filde_component.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/add_property/component/add_image_component.dart';
import 'package:manzal_office/features/add_property/component/add_property_category_component.dart';
import 'package:manzal_office/features/add_property/component/add_property_type_component.dart';
import 'package:manzal_office/features/add_property/controller/add_property_cubit.dart';

import '../../core/constant/color.dart';

class AddPropertyFirstPage extends StatelessWidget {
  const AddPropertyFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AddPropertyCubit.get(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(height: screenHeight(context) * 0.01),

          CircleIcon(
            icon: Icons.arrow_back_ios_new,
            iconOnTap: () {
              navigatPop(context: context);
            },
          ),
          SizedBox(height: screenHeight(context) * 0.01),
          SectionComponent(title: "Property Image:"),
          SizedBox(height: screenHeight(context) * 0.01),
          AddImageComponent(),

          SizedBox(height: screenHeight(context) * 0.05),
          SectionComponent(title: 'Property Title:'),
          SizedBox(height: screenHeight(context) * 0.01),
          TextFromFildeComponent(
            validator: (value){
              if (value == null || value.isEmpty) {
                return 'you must enter the Property description';
              }
            },
            hintText: 'Title',
            //  suffixIcon: Icons.home,
            controller:cubit.titleController,
          ),
          SizedBox(height: screenHeight(context) * 0.05),
          SectionComponent(title: 'Property Category:'),
          SizedBox(height: screenHeight(context) * 0.01),
          AddPropertyCategoryComponent(),
          SizedBox(height: screenHeight(context) * 0.05),
          SectionComponent(title: 'Property Type:'),
          SizedBox(height: screenHeight(context) * 0.01),
          AddPropertyTypeComponent(),
          SizedBox(height: screenHeight(context) * 0.05),
          BlocBuilder<AddPropertyCubit, AddPropertyState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: ButtomComponent(
                  color:
                  cubit.images.any((image) => image != null)
                      ? mainColor1
                      : Colors.grey,
                  text: 'next',
                  onPressed: () {
                    if (cubit.images.any((image) => image != null)) {
                      cubit.BoardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    } else {
                      cubit.BoardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  icon: Icons.arrow_forward_ios_sharp,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
