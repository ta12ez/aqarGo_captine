import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/navigator.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/add_property/add_property_first_page.dart';
import 'package:manzal_office/features/add_property/add_property_second_page.dart';
import 'package:manzal_office/features/add_property/controller/add_property_cubit.dart';

import '../../core/constant/color.dart' show mainColor1, mainColor2;

class AddProperty extends StatelessWidget {
  AddProperty({super.key});

  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController spaceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddPropertyCubit()..getState()..getRegion(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocConsumer<AddPropertyCubit, AddPropertyState>(
            listener: (context, state){
              if(state is AddPropertySuccess){
                navigatPop(context: context);
              }
            },
            builder: (context, state) {
              var cubit=AddPropertyCubit.get(context);
              if(state is GetStateLoading || state is GetRegionLoading ){
                return Center(
                  child: CircularProgressIndicator(color: mainColor1,),
                );
              }
              else if(cubit.states!=null&&cubit.reagions!=null){
                return Column(
                  children: [

                    SizedBox(height: screenHeight(context)*0.01,),
                    Row(
                      children: List.generate(2 * 2 - 1, (index) {
                        if (index.isEven) {
                          int stepIndex = index ~/ 2;
                          bool isSelected = stepIndex == cubit.currentPageIndex;
                          bool isCompleted = stepIndex < cubit.currentPageIndex;

                          return Container(

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: isSelected
                                    ? mainColor1
                                    : isCompleted
                                    ? mainColor1.withOpacity(0.7)
                                    : Colors.grey.shade300,
                              ),

                            ),
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Text(
                                '${stepIndex + 1}',
                                style:Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: isSelected || isCompleted ? mainColor1 : Colors.grey.shade300,

                                )

                            ),
                          );
                        } else {
                          bool isPassed = index ~/ 2 < cubit.currentPageIndex;
                          return Expanded(
                            child: Container(
                              height: 3,
                              color: isPassed ? mainColor1 : Colors.grey.shade300,
                            ),
                          );
                        }
                      }),
                    ),
                    SizedBox(height: 16),
                    if(state is AddPropertyLoading)
                      LinearProgressIndicator(color: mainColor1,),
                    if(state is AddPropertyLoading)
                      SizedBox(height: 5),

                    Expanded(
                      child: PageView(
                        onPageChanged: (index) {
                          cubit.setCurrentPage(index);
                        },
                        physics: NeverScrollableScrollPhysics(),
                        controller: cubit.BoardController,
                        children: [
                          AddPropertyFirstPage(),
                          AddPropertySecondPage(),

                        ],
                      ),
                    ),
                  ],
                );

              }else{
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: mainColor2,
                      ),
                      Text(
                        "No data",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: mainColor2),
                      ),

                    ],),
                );

              }
            },
          ),
        ),
      ),);
  }
}
