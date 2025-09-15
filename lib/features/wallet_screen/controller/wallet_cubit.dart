import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/showToast.dart';
import 'package:manzal_office/core/constant/payment.dart';
import 'package:manzal_office/core/network/remote/apis_const.dart';
import 'package:manzal_office/core/network/remote/dioHelper.dart';
import 'package:manzal_office/core/network/remote/header_constance.dart';
import 'package:manzal_office/features/wallet_screen/model/charge_model.dart';
import 'package:manzal_office/features/wallet_screen/model/transaction_model.dart';
import 'package:meta/meta.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());
  static WalletCubit get(context)=>BlocProvider.of(context);
  Future<void> storeProfit(String price)async{
    try {
        final response = await DioHelper.postData(
          url: ApiConstance.storeprofite,
          token: HeaderConstance.token,
          data: {"type":"balance","profite":"${price}"},
        );
        if (response.statusCode == 200||response.statusCode == 201) {

          showToast(msg: "تم شحن محفظتك", state: ToastState.SUCCESS);
          emit(RechargeSuccessState());
         print("success");
        } else {
          emit(RechargeErrorState());
        }


    } catch (e) {
      emit(RechargeErrorState());
      print(e.toString());
    }
  }
  List<TransactionModel>? transactions;
 void getTransactions(){
   print(HeaderConstance.token);
   transactions=null;
    print("dd");
    emit(GetTransactionLoadingState());
    DioHelper.getData(url:ApiConstance.getTransaction,token: HeaderConstance.token )
        .then((value){
      if(value.statusCode==200&&value.data!=null){
        List<dynamic>data=value.data["transactions"];
       transactions = data.map((e)=>TransactionModel.fromJson(e)).toList();
        emit(GetTransactionSuccessState());
      }
    }).catchError((e){
      transactions=[];
      showToast(msg: "حدث خطأ", state: ToastState.ERORR);
      if (e is DioException) {
        if (e.response != null) {
          print("Error: ${e.response?.data}");
        } else {
          print("Error1: ${e.message}");
        }
      } else {
        print("Unexpected error: $e");
      }
      emit(GetTransactionErrorState());
    });
  }

  String? balance;
  void getBalance(){
    balance=null;
    print("dds");
    emit(GetBalanceLoadingState());
    DioHelper.getData(url:ApiConstance.getBalance,token: HeaderConstance.token )
        .then((value){
      if(value.statusCode==200&&value.data!=null){
        balance=value.data["balance"];
        print(balance);
        emit(GetBalanceSuccessState());
      }
    }).catchError((e){
      balance='';
      showToast(msg: "حدث خطأ", state: ToastState.ERORR);
      if (e is DioException) {
        if (e.response != null) {
          print("Error: ${e.response?.data}");
        } else {
          print("Error1: ${e.message}");
        }
      } else {
        print("Unexpected error: $e");
      }
      emit(GetBalanceErrorState());
    });
  }
  List<ChargeModel>charges=[
    ChargeModel(amount: "10", price: "2"),
    ChargeModel(amount: "20", price: "4"),
    ChargeModel(amount: "30", price: "6"),
    ChargeModel(amount: "40", price: "8"),
    ChargeModel(amount: "50", price: "10"),
    ChargeModel(amount: "60", price: "12"),
    ChargeModel(amount: "70", price: "14"),
    ChargeModel(amount: "80", price: "16"),
    ChargeModel(amount: "90", price: "18"),
    ChargeModel(amount: "100", price: "20"),

  ];
  int chargeIndex=0;
  void changeChargeIndex(int index){
    chargeIndex=index;
    emit(ChangeChargeIndex());
  }
  void chargeWallet()  async{
    emit(RechargeLoadingState());
    try {
      bool success=await pay(amount: charges[chargeIndex].price);
      if(success){
        final response = await DioHelper.postData(
          url: ApiConstance.confirmRecharge,
          token: HeaderConstance.token,
          data: {"amount":  charges[chargeIndex].amount},
        );
        if (response.statusCode == 200) {
        await  storeProfit( charges[chargeIndex].price);
        } else {
          showToast(msg: "فشل شحن محفظتك", state: ToastState.ERORR);
          emit(RechargeErrorState());
        }
      }
      else{

        showToast(msg: "تم ايقاف عملية شحن محفظتك", state: ToastState.ERORR);
        emit(RechargeCanceledState());
      }

    } catch (e) {
      showToast(msg: "فشل شحن محفظتك", state: ToastState.ERORR);
      emit(RechargeErrorState());
      print(e.toString());
    }
  }

}
