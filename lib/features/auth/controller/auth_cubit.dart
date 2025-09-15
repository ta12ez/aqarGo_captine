import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/features/home_page/home_page.dart';
import '../../../core/component/navigator.dart';
import '../../../core/network/local/cachHelper.dart';
import '../../../core/network/remote/apis_const.dart';
import '../../../core/network/remote/dioHelper.dart';
import '../../../core/network/remote/header_constance.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);


  void login (String email,String password,context) {
    emit(LoginLoadState());
    print("test");
    print(email);
    print(password);
    DioHelper.postData(url: ApiConstance.login
        ,data: {
      "email":"$email",
      "password":"$password"
    }).then((value) {
      print('success1');

      if(value.statusCode ==200) {
        print('success');
        emit(LoginSuccessState());
        print(value.data["token"]);
        CacheHelper.saveData(key: "token", value:"${value.data["token"]}" ).then((valuee){
          if(valuee){
            HeaderConstance.token = value.data["token"];
            navigatTo(context: context, page: HomePage());
            saveUserToken(fcmToken: HeaderConstance.fcmToken);
          }
        });
      }
    }).catchError(( e){
      if (e is DioException) {
        if (e.response != null) {
          print("Error: ${e.response?.data}");
        //  ShowTaost(msg:"الرجاء التأكد من صحة الايميل و كلمة السر", state: ToastState.ERORR);
        } else {
          print("Error: ${e.error}");
        //  ShowTaost(msg: "  تأكد من جودة الاتصال او صحة URL", state: ToastState.WARNING);
        }
      } else {
        print("Unexpected error: $e");
      //  ShowTaost(msg: "حدث خطأ غير متوقع", state: ToastState.ERORR);
      }
      emit(LoginErrorState());
    });
  }


  void register (String officeName,String email,String phone,String profitPercentage,String description,String password,String confirmPassword,context) {
    emit(RegisterLoadState());
    DioHelper.postData(url: ApiConstance.register
        ,data: {
          "Office_name":"$officeName",
          "email":"$email",
          "PhoneNumberOffice":"$phone",
          "percentage":"$profitPercentage",
          "description":"$description",
          "password":"$password",
        "c_password":"$confirmPassword",
        }).then((value) {
      print('success1');

      if(value.statusCode ==200||value.statusCode ==201) {
        print('success');
        emit(RegisterSuccessState());
        print(value.data["token"]);
        CacheHelper.saveData(key: "token", value:"${value.data["token"]}" ).then((valuee){
          if(valuee){
            print("nav");
            HeaderConstance.token = value.data["token"];
            navigatTo(context: context, page: HomePage());
            saveUserToken(fcmToken: HeaderConstance.fcmToken);
          }
        });
      }
    }).catchError(( e){
      if (e is DioException) {
        if (e.response != null) {
          print("Error: ${e.response?.data}");
          //  ShowTaost(msg:"الرجاء التأكد من صحة الايميل و كلمة السر", state: ToastState.ERORR);
        } else {
          print("Error1: ${e.toString()}");
          //  ShowTaost(msg: "  تأكد من جودة الاتصال او صحة URL", state: ToastState.WARNING);
        }
      } else {
        print("Unexpected error: $e");
        //  ShowTaost(msg: "حدث خطأ غير متوقع", state: ToastState.ERORR);
      }
      emit(RegisterErrorState());
    });
  }

  void saveUserToken({required String fcmToken}) {
    emit(SaveTokenLoadingState());
    DioHelper.postData(
        url: ApiConstance.saveOfficeToken,
        token: HeaderConstance.token,
        data:{
          "fcm_token":"$fcmToken"
        }
    ).then((value) {
      if (value.statusCode == 200) {
        emit(SaveTokenSuccessState());
        print("${value.data}");
      }
    }).catchError((e) {
      if (e is DioException) {
        if (e.response != null) {
          print("Error: ${e.response?.data}");
        } else {
          print("Error1: ${e.message}");
        }
      } else {
        print("Unexpected error: $e");
      }
      emit(SaveTokenErrorState());
    });
  }



}
