import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/circle_icon.dart';
import 'package:manzal_office/core/component/navigator.dart';
import 'package:manzal_office/core/component/shimmer_component.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/features/wallet_screen/charge_wallet_screen.dart';
import 'package:manzal_office/features/wallet_screen/controller/wallet_cubit.dart';
import 'package:manzal_office/features/wallet_screen/model/transaction_model.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              WalletCubit()
                ..getBalance()
                ..getTransactions(),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleIcon(
              icon: Icons.arrow_back_ios_new_rounded,
              iconOnTap: () => Navigator.pop(context),
            ),
          ),
          title: Text('Wallet', style: Theme.of(context).textTheme.titleSmall),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              BlocBuilder<WalletCubit, WalletState>(

                buildWhen:
                    (previous, current) =>
                        current is GetBalanceLoadingState ||
                        current is GetBalanceSuccessState ||
                        current is GetBalanceErrorState,
                builder: (context, state) {
                  WalletCubit cubit = WalletCubit.get(context);

                  if (state is GetBalanceLoadingState||cubit.balance==null) {
                    return ShimmerComponent(
                      height: screenHeight(context) * 0.2,
                      width: double.infinity,
                      itemCount: 1,
                    );
                  } else if (cubit.balance != null&&cubit.balance!='') {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [mainColor2, mainColor1],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Your Balance:",
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .copyWith(color: whitColor),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: (){
                                     navigatTo(context: context, page: ChargeWalletScreen(cubit: cubit,));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: whitColor,
                                      borderRadius: BorderRadius.all(Radius.circular(50)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text("Charge Now",style: Theme.of(context).textTheme.titleSmall!.copyWith(color: mainColor1),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${cubit.balance}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: whitColor),
                                  ),
                                ),
                                const Icon(
                                  Icons.stars_rounded,
                                  color: Colors.yellowAccent,
                                  size: 36,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Icon(Icons.error_outline, color: mainColor2, size: 35),
                        SizedBox(height: 10),
                        Text(
                          "No Data",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your Transaction:",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: BlocBuilder<WalletCubit, WalletState>(
                  buildWhen:
                      (previous, current) =>
                          current is GetTransactionLoadingState ||
                          current is GetTransactionSuccessState ||
                          current is GetTransactionErrorState,
                  builder: (context, state) {
                    WalletCubit cubit = WalletCubit.get(context);

                    if (state is GetTransactionLoadingState||cubit.transactions==null) {
                      return ShimmerComponent(
                        height: screenHeight(context) * 0.1,
                        width: double.infinity,
                        itemCount: 6,
                      );
                    } else if (cubit.transactions != null &&
                        cubit.transactions!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: cubit.transactions!.length,
                        itemBuilder: (context, index) {
                          TransactionModel trans = cubit.transactions![index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    trans.type=="credit" ? Colors.green[100] : Colors.red[100],
                                child: Icon(
                                  trans.type=="credit" ? Icons.add : Icons.remove,
                                  color: trans.type=="credit" ? Colors.green : Colors.red,
                                ),
                              ),
                              title: Text(
                                "${trans.amount}",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              subtitle: Text(
                                "${trans.description}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              trailing: Text(
                                "${trans.type}",
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium!.copyWith(
                                  color: trans.type=="credit" ? mainColor1 : Colors.red,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: mainColor2,
                            size: 35,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "No Data",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
