import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:manzal_office/core/constant/constant.dart';

import 'package:manzal_office/core/network/local/cachHelper.dart';
import 'package:manzal_office/core/network/remote/apis_const.dart';
import 'package:manzal_office/core/network/remote/dioHelper.dart';
import 'package:manzal_office/core/network/remote/header_constance.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context)=>BlocProvider.of(context);
  Locale locale=CacheHelper.getData(key: 'language')!=null? Locale(CacheHelper.getData(key: 'language')): Locale('en');
  void changeLanguage ({required Locale newLocale
  })async{
    locale = newLocale;
    await CacheHelper.saveData(key: "language", value: newLocale.languageCode).then((value){
      emit(ChangeLanguageState(locale: newLocale));

    });}

 void getSubsicption(){
    emit(GetSubsiciptionLoadingState());
     DioHelper.getData(url: ApiConstance.getSubsicription,token: HeaderConstance.token).then((value){
      if(value.statusCode==200){
        bool status=value.data["status"];
        Constant.subscription=status;
        emit(GetSubsiciptionSuccessState());
      }else{
        emit(GetSubsiciptionErrorState());
      }
    }).catchError((e){
       emit(GetSubsiciptionErrorState());
  print(e);
    });
  }
}
