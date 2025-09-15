import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/circle_icon.dart';
import 'package:manzal_office/core/component/navigator.dart';
import 'package:manzal_office/core/component/showToast.dart';
import 'package:manzal_office/core/constant/constant.dart';
import 'package:manzal_office/core/constant/payment_enum.dart';
import 'package:manzal_office/core/controller/payment_controller/payment_cubit.dart';
import 'package:manzal_office/features/subscription/component/monthly_subscription.dart';
import 'package:manzal_office/features/subscription/component/year_subscription.dart';
import 'package:manzal_office/features/subscription/controller/subscription_cubit.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => SubscriptionCubit(),
  child: Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleIcon(
            icon: Icons.arrow_back_ios_new_rounded,
            iconOnTap: () => Navigator.pop(context),
          ),
        ),
        title: Text('Subscription', style: Theme.of(context).textTheme.titleSmall),
      ),
      body: BlocListener<SubscriptionCubit, SubscriptionState>(
  listener: (context, state) {
    if(state is SubscriptionSuccessState){
      Constant.subscription=true;
      showToast(msg: "تم الاشتراك", state: ToastState.SUCCESS);
      navigatPop(context: context);
    }else if(state is SubscriptionErrorState){
      showToast(msg: "فشل الاشتراك", state: ToastState.ERORR);
    }
    else if(state is SubscriptionCanceledState){
      showToast(msg: "تم ايقاف عملية الاشتراك", state: ToastState.ERORR);
    }
  },
  child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Choose the plan that suits you best!",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => currentPage = index),
              physics: BouncingScrollPhysics(),
              children: const [
                MonthlySubscription(),
                YearSubscription(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              2,
                  (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentPage == index ? 16 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: currentPage == index ? Colors.blue : Colors.grey[400],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
),
    ),
);
  }
}
