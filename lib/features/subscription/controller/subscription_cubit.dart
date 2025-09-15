import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:manzal_office/core/component/showToast.dart';
import 'package:manzal_office/core/constant/payment.dart';
import 'package:manzal_office/core/constant/payment_enum.dart';
import 'package:manzal_office/core/network/remote/apis_const.dart';
import 'package:manzal_office/core/network/remote/dioHelper.dart';
import 'package:manzal_office/core/network/remote/header_constance.dart';
import 'package:meta/meta.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionInitial());
  static SubscriptionCubit get(context)=>BlocProvider.of(context);
  Future<void> storeProfit(String price)async{
    try {
      final response = await DioHelper.postData(
        url: ApiConstance.storeprofite,
        token: HeaderConstance.token,
        data: {"type":"Subscription","profite":"${price}"},
      );
      if (response.statusCode == 200||response.statusCode == 201) {

        print("success1");
      } else {
        print("erorr");

        throw Exception("can not store profit1");
      }


    } catch (e) {
      print("erorr");

      print(e.toString());

      throw Exception("can not store profit");
    }
  }

  Future<void> chargeWallet(String amount) async {
    try {
        final response = await DioHelper.postData(
          url: ApiConstance.confirmRecharge,
          token: HeaderConstance.token,
          data: {"amount": amount},
        );
        if (response.statusCode == 200) {

          print("success");

        } else {
          throw Exception("can not store charge1");
        }

    } catch (e) {

      print(e.toString());
      throw Exception("can not store charge2");

    }
  }

  Future<void> monthlySubscipe() async {
    emit(SubscriptionLoadingState());
    try {
      final success = await pay(amount: "20");
      if (success) {
        final response = await DioHelper.postData(
          url: ApiConstance.subscripe,
          token: HeaderConstance.token,
          data: {"subscription_type": "monthly"},
        );
        if (response.statusCode == 200) {
          await chargeWallet("20");
          await storeProfit("20");
          emit(SubscriptionSuccessState());

        } else {
          emit(SubscriptionErrorState());
        }
      } else {
        emit(SubscriptionCanceledState());
      }
    } catch (e) {
      emit(SubscriptionErrorState());
      print(e.toString());
    }
  }

  Future<void> yearlySubscipe() async {
    emit(SubscriptionLoadingState());
    try {
      final success = await pay(amount: "100");
      if (success) {
        final response = await DioHelper.postData(
          url: ApiConstance.subscripe,
          token: HeaderConstance.token,
          data: {"subscription_type": "yearly"},
        );
        if (response.statusCode == 200) {
          await chargeWallet("50");
          await storeProfit("100");
          emit(SubscriptionSuccessState());
        } else {
          emit(SubscriptionErrorState());
        }
      } else {
        emit(SubscriptionCanceledState());
      }
    } catch (e) {
      emit(SubscriptionErrorState());
      print(e.toString());
    }
  }


}
