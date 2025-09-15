import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/buttom_component.dart';
import 'package:manzal_office/core/component/circle_icon.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/wallet_screen/controller/wallet_cubit.dart';

class ChargeWalletScreen extends StatelessWidget {
  WalletCubit cubit;

  ChargeWalletScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleIcon(
              icon: Icons.arrow_back_ios_new_rounded,
              iconOnTap: () => Navigator.pop(context),
            ),
          ),
          title: Text('Charge Wallet', style: Theme
              .of(context)
              .textTheme
              .titleSmall),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {

              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: cubit.charges.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: screenWidth(context) * 0.05,
                        mainAxisSpacing: screenHeight(context) * 0.015,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            cubit.changeChargeIndex(index);
                          },
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: cubit.chargeIndex==index? BorderSide(
                                color: mainColor1,
                                width: 2,
                              ):BorderSide.none,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(child: Text(cubit.charges[index].amount,style: Theme.of(context).textTheme.titleMedium,)),
                                   SizedBox(width: 5,),
                                      const Icon(
                                        Icons.stars_rounded,
                                        color: Colors.yellowAccent,
                                        size: 36,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Text("${cubit.charges[index].price}\$",style: Theme.of(context).textTheme.titleSmall,),

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight(context) * 0.02,),
                  BlocBuilder<WalletCubit, WalletState>(
  builder: (context, state) {
    if(state is RechargeLoadingState){
      return Center(child: CircularProgressIndicator(color: mainColor1,),);
    }
    return SizedBox(
                      width: double.infinity,
                      child: ButtomComponent(text: "charge", onPressed: () {
                        cubit.chargeWallet();
                      }));
  },
),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
