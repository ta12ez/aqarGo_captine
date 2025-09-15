// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:manzal_office/core/component/showToast.dart';
// import 'package:manzal_office/core/constant/payment_enum.dart';
// import 'package:manzal_office/core/network/remote/apis_const.dart';
// import 'package:manzal_office/core/network/remote/dioHelper.dart';
// import 'package:manzal_office/core/network/remote/header_constance.dart';
// import 'package:meta/meta.dart';
//
// part 'payment_state.dart';
//
// class PaymentCubit extends Cubit<PaymentState> {
//   PaymentCubit() : super(PaymentInitial());
// static PaymentCubit get(context)=>BlocProvider.of(context);
//   Future<void> createPay({required String amount,required PaymentType type})async {
//     emit(CreatePayLoadingState());
//     String? clientSecretKey;
//     DioHelper.postData(url: ApiConstance.createPay,token: HeaderConstance.token,data: {
//       "amount":"$amount",
//     })
//         .then((value){
//       if(value.statusCode==200&&value.data!=null){
//         print(value.data["clientSecret"]);
//         clientSecretKey=value.data["clientSecret"];
//         emit(CreatePaySuccessState(clientSecret: clientSecretKey!,type:type));
//       }
//     }).catchError((e){
//       showToast(msg: "حدث خطأ", state: ToastState.ERORR);
//       if (e is DioException) {
//         if (e.response != null) {
//           print("Error: ${e.response?.data}");
//         } else {
//           print("Error1: ${e.message}");
//         }
//       } else {
//         print("Unexpected error: $e");
//       }
//       emit(CreatePayErrorState());
//     });
//   }
//
//
//   Future<void> pay({required String clientSecret ,required PaymentType type}) async {
//     emit(PayLoadingState());
//
//     try {
//       await Stripe.instance.initPaymentSheet(
//
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: clientSecret,
//           merchantDisplayName: 'Aqary',
//
//         ),
//       ).then((value){
//         print(value.toString());
//
//       });
//
//       await Stripe.instance.presentPaymentSheet().then((value){
//         print(value.toString());
//       });
//
//       print("succes");
//       emit(PaySuccessState(type: type));
//     } on StripeException catch (e) {
//       if (e.error.code == FailureCode.Canceled) {
//         print(e.toString());
//         emit(PayErrorState());
//       } else {
//         emit(PayErrorState());
//       }
//     } catch (e) {
//       emit(PayErrorState());
//     }
//   }
// }
