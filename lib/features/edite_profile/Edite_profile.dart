import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/circle_icon.dart';
import 'package:manzal_office/core/component/navigator.dart';
import 'package:manzal_office/core/component/text_from_filde_component.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/core/network/remote/apis_const.dart';
import 'package:manzal_office/features/edite_profile/controller/edit_profile_cubit.dart';
import 'package:manzal_office/features/profile/controller/profile_cubit.dart';

import '../../core/component/buttom_component.dart';
import '../../core/constant/app_localizations.dart';

class EditeProfile extends StatelessWidget {
  String name;
  String description;
  String percentage;
  String phone;
  String email;
  String imageurl;

  EditeProfile({super.key,required this.phone,required this.name,required this.email,required this.percentage,required this.description,required this.imageurl});
   TextEditingController firstNameController =TextEditingController();
   TextEditingController emailController =TextEditingController();
   TextEditingController phoneController =TextEditingController();
   TextEditingController descriptionController =TextEditingController();
   TextEditingController percentageController =TextEditingController();


   @override
  Widget build(BuildContext context) {
     firstNameController.text=name;
     emailController.text=email;
     phoneController.text=phone;
     descriptionController.text=description;
     percentageController.text=percentage;
     final localizer = AppLocalizations.of(context);
     final isArabic = Localizations.localeOf(context).languageCode == 'ar';
     final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    return  BlocProvider(
  create: (context) => EditProfileCubit(),
  child: BlocConsumer<EditProfileCubit, EditProfileState>(
  listener: (context, state) {
    if(state is EditProfileSuccessState){
      navigatPop(context: context);
    }
  },
  builder: (context, state) {
    EditProfileCubit cubit = EditProfileCubit.get(context);
    return Directionality(
      textDirection:  isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar:   AppBar(
          leading:  Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleIcon(
              icon: Icons.arrow_back_ios_new_rounded,
              iconOnTap: () {
                Navigator.pop(context);
              },
            ),
          ),

          title: Text('${localizer.translate("edit")} ${localizer.translate("profile")}',style: Theme.of(context).textTheme.titleSmall,),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                       cubit.images!=null? CircleAvatar(

                          radius:60 ,
                          backgroundImage: FileImage(File(cubit.images!.path)),
                        ):
                        CircleAvatar(

                          radius:60 ,
                          backgroundImage: NetworkImage(ApiConstance.urlImage(imageurl)),
                        ),
                        Positioned(
                          bottom: 0,
                            right: 0,
                            child: CircleIcon(iconOnTap: (){                      cubit.pickImage();
                            },icon: Icons.edit,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight(context)*0.05,),
                  Text("${localizer.translate("name")}:",style: Theme.of(context).textTheme.titleSmall,),
                  SizedBox(height: screenHeight(context)*0.01,),
                  TextFromFildeComponent(hintText: 'firstName', controller: firstNameController,),
                  SizedBox(height: screenHeight(context)*0.02,),
                  Text("${localizer.translate("description")}:",style: Theme.of(context).textTheme.titleSmall,),
                  SizedBox(height: screenHeight(context)*0.01,),
                  TextFromFildeComponent(hintText: 'description', controller: descriptionController,maxLines: 5,),
                  SizedBox(height: screenHeight(context)*0.02,),
                  Text("${localizer.translate("percentage")}:%",style: Theme.of(context).textTheme.titleSmall,),
                  SizedBox(height: screenHeight(context)*0.01,),
                  TextFromFildeComponent(hintText: 'percentage', controller: percentageController,), SizedBox(height: screenHeight(context)*0.02,),
                  // Text("Phone:",style: Theme.of(context).textTheme.titleSmall,),
                  // SizedBox(height: screenHeight(context)*0.01,),
                  // TextFromFildeComponent(hintText: 'phone', controller: phoneController,keyboardType: TextInputType.phone,),
                  SizedBox(height: screenHeight(context)*0.02,),
                  Text("${localizer.translate("email")}:",style: Theme.of(context).textTheme.titleSmall,),
                  SizedBox(height: screenHeight(context)*0.01,),
                  TextFromFildeComponent(hintText: 'email', controller: emailController,keyboardType: TextInputType.emailAddress,),
                  SizedBox(height: screenHeight(context)*0.05,),
                  SizedBox(
                      width: double.infinity,
                      child:state is EditProfileLoadingState ? Center(child: CircularProgressIndicator(color: mainColor1,),):ButtomComponent(text: '${localizer.translate("save")}', onPressed: () {
                        cubit.editProfile(
                          email: emailController.text==email?null:emailController.text,
                          percentage: percentageController.text==percentage?null:percentageController.text,
                          name: firstNameController.text==name?null:firstNameController.text,
                          description: descriptionController.text==description?null:descriptionController.text,
                          phone: phoneController.text==phone?null:phoneController.text,

                        );
                      },)),
                ],
              ),
          ),
        ),
      ),
    );
  },
),
);
  }
}
