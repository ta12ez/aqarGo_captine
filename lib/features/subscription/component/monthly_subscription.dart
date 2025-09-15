import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/buttom_component.dart';
import 'package:manzal_office/core/constant/color.dart';
import 'package:manzal_office/core/constant/payment_enum.dart';
import 'package:manzal_office/core/constant/screen_size.dart';
import 'package:manzal_office/core/controller/payment_controller/payment_cubit.dart';
import 'package:manzal_office/features/subscription/component/bill_item.dart';
import 'package:manzal_office/features/subscription/controller/subscription_cubit.dart';

class MonthlySubscription extends StatelessWidget {
  const MonthlySubscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Monthly Subscription",style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: screenHeight(context)*0.05,),

              BillItem(firstText: "20\$", secondText: "per month", iconData: Icons.monetization_on),
              Divider(),
              BillItem(firstText: "20", secondText: "Point", iconData: Icons.control_point_outlined),
              Divider(),
              BillItem(firstText: "Add Property", secondText: "✓ Included", iconData: Icons.add_home_work),
              Divider(),
              BillItem(firstText: "Manage Properties", secondText: "✓ Included", iconData: Icons.manage_accounts),
              Divider(),
              BillItem(firstText: "Manage User Requests", secondText: "✓ Included", iconData: Icons.person_search),
              SizedBox(height: screenHeight(context)*0.05,),
              BlocBuilder<SubscriptionCubit, SubscriptionState>(
              builder: (context, state) {
                SubscriptionCubit cubit=SubscriptionCubit.get(context);
                return state is SubscriptionLoadingState ? CircularProgressIndicator(color: mainColor1,):ButtomComponent(text: 'Subscribe monthly', onPressed: () {
                  cubit.monthlySubscipe();
                });
              },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
