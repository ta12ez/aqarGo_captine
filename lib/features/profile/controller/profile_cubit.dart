import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/showToast.dart';
import 'package:manzal_office/core/network/remote/apis_const.dart';
import 'package:manzal_office/core/network/remote/dioHelper.dart';
import 'package:manzal_office/core/network/remote/header_constance.dart';
import 'package:manzal_office/features/auth/login.dart';
import 'package:manzal_office/features/profile/model/profile_model.dart';
import 'package:meta/meta.dart';

import '../../../core/network/local/cachHelper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context)=> BlocProvider.of(context);
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  ProfileModel? profile;
  void getProfile(){
    emit(GetProfileDataLoading());
    DioHelper.getData(url: ApiConstance.getOfficeProfile,token: HeaderConstance.token)
    .then((value){
      if(value.statusCode==200){
        profile=ProfileModel.fromJson(value.data);
        print(profile!.id);
        emit(GetProfileDataSuccess());
      }
    }).catchError((e){
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
      emit(GetProfileDataError());
    });
  }

  void logOut(context) {
    emit(LogOutloadingState());
    DioHelper.postData(
      url: ApiConstance.logOutOffice,
      token: HeaderConstance.token,
    ).then((value) async {
      if (value.statusCode == 200) {
        CacheHelper.removeData(key: "token");
        HeaderConstance.token = "";
        await _messaging.deleteToken();
        HeaderConstance.fcmToken="${await _messaging.getToken()}";
        print(HeaderConstance.fcmToken);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
              (Route<dynamic> route) => false, // يمنع الرجوع نهائيًا
        );
        emit(LogOutSuccessState());
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
      emit(LogOutErrorState());
    });
  }
}

