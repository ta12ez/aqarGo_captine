
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:manzal_office/core/component/showToast.dart';
import 'package:manzal_office/core/network/remote/apis_const.dart';
import 'package:manzal_office/core/network/remote/dioHelper.dart';
import 'package:manzal_office/core/network/remote/header_constance.dart';

Future<String> createPay({required String amount}) async {
  try {
    print(HeaderConstance.token);
    print("paycreating");
    final response = await DioHelper.postData(
      url: ApiConstance.createPay,
      token: HeaderConstance.token,
      data: {
        "amount": amount,
      },
    );

    if (response.statusCode == 200 && response.data != null) {
      print("Client Secret: ${response.data["clientSecret"]}");
      return response.data["clientSecret"];
    } else {
      throw Exception("فشل إنشاء عملية الدفع");
    }
  } catch (e) {
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
    rethrow;
  }
}

Future<bool> pay({required String amount}) async {
  try {
    final clientSecret = await createPay(amount: amount);
    print("pay");
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Aqary',
      ),
    );

    await Stripe.instance.presentPaymentSheet();

    print(" Payment Success");
    showToast(msg: "تم الدفع بنجاح", state: ToastState.SUCCESS);
    return true;

  } on StripeException catch (e) {
    if (e.error.code == FailureCode.Canceled) {
      print(" Payment Canceled");
      showToast(msg: "تم إلغاء الدفع", state: ToastState.ERORR);
      return false;
    } else {
      print("Stripe Error: ${e.error.localizedMessage}");
      showToast(msg: "خطأ في عملية الدفع", state: ToastState.ERORR);
      rethrow;
    }
  } catch (e) {
    print("Unexpected Error: $e");
    showToast(msg: "حدث خطأ غير متوقع", state: ToastState.ERORR);
    rethrow;
  }
}
