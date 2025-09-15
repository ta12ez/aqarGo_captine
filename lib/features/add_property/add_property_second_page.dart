import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/buttom_component.dart';
import 'package:manzal_office/core/component/circle_icon.dart';
import 'package:manzal_office/core/component/section_component.dart';
import 'package:manzal_office/core/component/text_from_filde_component.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/add_property/component/add_contract_types_component.dart';
import 'package:manzal_office/features/add_property/component/add_location_component.dart';
import 'package:manzal_office/features/add_property/controller/add_property_cubit.dart';

class AddPropertySecondPage extends StatelessWidget {

  AddPropertySecondPage({super.key});
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit=AddPropertyCubit.get(context);
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleIcon(
              icon: Icons.arrow_back_ios_new,
              iconOnTap: () {
                cubit.BoardController.previousPage(duration: Duration(milliseconds: 750), curve:Curves.fastLinearToSlowEaseIn);
              },
            ),
            SizedBox(height: screenHeight(context) * 0.01),
            SectionComponent(title: 'الموقع - المحافظة والمنطقة:'),
            SizedBox(height: screenHeight(context) * 0.01),
            AddLocationComponent(),
            SizedBox(height: screenHeight(context) * 0.05),
            SectionComponent(title: "location description:"),
            SizedBox(height: screenHeight(context) * 0.01),
            TextFromFildeComponent(
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'you must add your property location description';
                }
              },

              hintText: 'location description',
              //  suffixIcon: Icons.home,
              maxLines: 3,
              controller: cubit.locationDescController,
            ),
            SizedBox(height: screenHeight(context) * 0.05),
            SectionComponent(title: 'Contract Type:'),
            SizedBox(height: screenHeight(context) * 0.01),
            AddContractTypesComponent(),
            SizedBox(height: screenHeight(context) * 0.05),
            SectionComponent(title: "Property price:"),
            SizedBox(height: screenHeight(context) * 0.01),
            BlocBuilder<AddPropertyCubit, AddPropertyState>(
              builder: (context, state) {
                // var cubit = AddPropertyCubit.get(context);
                return Row(
                  children: [
                    Expanded(
                      child: TextFromFildeComponent(
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'you must enter the price';
                          }
                          if(value == '0'){
                            return 'it can not be 0';
                          }

                        },

                        hintText: 'price',
                        //  suffixIcon: Icons.monetization_on_outlined,
                        keyboardType: TextInputType.number,
                        controller:cubit.priceController,
                      ),
                    ),
                    SizedBox(width: 5),

                    Text(
                      '/\$',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(width: 5),
                    if (cubit.contractType == 'rent')
                      Text(
                        'per month',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                  ],
                );
              },
            ),
            SizedBox(height: screenHeight(context) * 0.05),
            SectionComponent(title: "Property Space:"),
            SizedBox(height: screenHeight(context) * 0.01),
            Row(
              children: [
                Expanded(
                  child: TextFromFildeComponent(
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'you must enter the space';
                      }
                      if(value == '0'){
                        return 'it can not be 0';
                      }
                    },

                    hintText: 'space',
                    keyboardType: TextInputType.number,
                    controller:cubit.spaceController,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '/meter^2',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            SizedBox(height: screenHeight(context) * 0.05),
            SectionComponent(title: "Property description:"),
            SizedBox(height: screenHeight(context) * 0.01),
            TextFromFildeComponent(
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'you must enter the Property description';
                }
              },
              hintText: 'description',
              //  suffixIcon: Icons.home,
              maxLines: 3,
              controller:cubit.descController,
            ),
            SizedBox(height: screenHeight(context) * 0.05),
            BlocBuilder<AddPropertyCubit, AddPropertyState>(
              builder: (context, state) {
                bool canMove = false;
                if(cubit.selectedGovernorate=='اختر المحافظة'||cubit.selectedArea==''){
                  canMove=false;
                }else{
                  canMove=true;

                }
                if(state is AddPropertyLoading){
                  return Center(child: CircularProgressIndicator(color: mainColor1,),);
                }
                return SizedBox(
                  width: double.infinity,
                  child: ButtomComponent(

                    color: canMove?mainColor1:Colors.grey,
                    text: 'add',
                    onPressed: () {
                      if(canMove){
                        if (formKey.currentState!.validate()) {
                          cubit.addProperty();

                        }}else{
                      }
                    },
                    icon: Icons.add,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
