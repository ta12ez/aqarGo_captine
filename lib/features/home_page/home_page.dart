import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/back_groung.dart';
import 'package:manzal_office/core/component/buttom_component.dart';
import 'package:manzal_office/core/component/dialog_component.dart';
import 'package:manzal_office/core/component/navigator.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/constant.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/accept_property/accept_property.dart';
import 'package:manzal_office/features/add_property/add_property.dart';
import 'package:manzal_office/features/followers/followers.dart';
import 'package:manzal_office/features/home_page/component/home_item_component.dart';
import 'package:manzal_office/features/home_page/controller/home_cubit.dart';
import 'package:manzal_office/features/profile/profile.dart';
import 'package:manzal_office/features/request/request_page.dart';
import 'package:manzal_office/features/subscription/subscription.dart';
import 'package:manzal_office/features/wallet_screen/wallet_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit= HomeCubit.get(context);
    return BlocProvider.value(
  value: cubit..getSubsicption(),
  child: Scaffold(
      body:BackGround(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if(state is GetSubsiciptionLoadingState||state is HomeInitial){
             return Center(child: CircularProgressIndicator(color: mainColor1,),);
            }else if(state is GetSubsiciptionErrorState){
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: mainColor2,
                      size: 40,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Check Your Connection...and Refresh",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: mainColor2),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ButtomComponent(text: "Refresh", onPressed: (){
                        cubit.getSubsicption();
                      }),
                    )
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight(context)*0.05,),
              
                  Text('Welcome You Can Manage Your property Easy Here',style: Theme.of(context).textTheme.titleSmall,),
                  SizedBox(height: screenHeight(context)*0.05,),
                  Center(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 10,
                      children: [
                        HomeItemComponent(iconData: Icons.note_add,title: 'Request',onTap: (){
                          if(Constant.subscription) {
                            navigatTo(context: context, page: RequestPage());
                          }else{
                            showDialogFunction(context);
                          }
                        },),
                        // HomeItemComponent(iconData: Icons.add,title: 'Add',onTap: (){
                        //   if(Constant.subscription) {
                        //     navigatTo(context: context, page: AddProperty());
                        //   }else{
                        //     showDialogFunction(context);
                        //   }
                        // },),

                        HomeItemComponent(iconData: Icons.account_balance,title: 'accepted properties',onTap: (){
                          if(Constant.subscription){
                            navigatTo(context: context, page: AcceptProperty());}
                          else{
                            showDialogFunction(context);
                          }
                        },),
                        HomeItemComponent(iconData: Icons.group,title: 'Followers',onTap: (){
                          if(Constant.subscription){
                            navigatTo(context: context, page: Followers());}
                          else{
                            showDialogFunction(context);
                          }
                        },),
                        HomeItemComponent(iconData: Icons.person,title: 'profile',onTap: (){
                          if(Constant.subscription) {
                            navigatTo(context: context, page: Profile());
                          }
                          else{
                            showDialogFunction(context);
                          }},),
                        HomeItemComponent(iconData: Icons.wallet,title: 'wallet',onTap: (){
                          if(Constant.subscription){
                            navigatTo(context: context, page: WalletScreen());}else{
                            showDialogFunction(context);
                          }},),
                        HomeItemComponent(iconData: Icons.payment,title: 'Subscription',onTap: (){
                            navigatTo(context: context, page: Subscription());

                        },),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        )
      )),
    ),
);
  }
  void showDialogFunction(context){
    showDialog(context: context, builder: (context)=>DialogComponent(
      confirmText: "Subscrip",
      cancelText: "no",
      title: "You are Not Subscrip",
      content: "يجب عليك الاشتراك لتتمكن من ادارة مكتبك",
      onConfirm: (){navigatTo(context: context, page: Subscription());},
    ));
  }
}
