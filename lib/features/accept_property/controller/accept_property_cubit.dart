import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/network/remote/apis_const.dart';
import 'package:manzal_office/core/network/remote/dioHelper.dart';
import 'package:manzal_office/core/network/remote/header_constance.dart';
import 'package:manzal_office/features/accept_property/model/accept_property_model.dart';
import 'package:meta/meta.dart';

import '../../../core/component/showToast.dart';

part 'accept_property_state.dart';

class AcceptPropertyCubit extends Cubit<AcceptPropertyState> {
  AcceptPropertyCubit() : super(AcceptPropertyInitial());
  static AcceptPropertyCubit get(context)=>BlocProvider.of(context);
  List<AcceptPropertyModel>? agriculturalProperties;
  List<AcceptPropertyModel>? residentalProperties;
  List<AcceptPropertyModel>? commercialProperties;
  List<AcceptPropertyModel>? industrialProperties;
  void getAcceptProperty(){
    print(HeaderConstance.token);
    emit(GetAcceptPropertyLoadingState());
    DioHelper.getData(url:ApiConstance.getAcceptedPropertiesForOffice,token: HeaderConstance.token )
    .then((value){
      if(value.statusCode==200){
        List<dynamic>data=value.data["accepted_properties"];
        List<AcceptPropertyModel>property=data.map((e)=>AcceptPropertyModel.fromJson(e)).toList();
        agriculturalProperties=[];
        residentalProperties=[];
        commercialProperties=[];
        industrialProperties=[];
        property.forEach((e){
          if(e.propertyCategory=="residental"){
            residentalProperties!.add(e);
          }
         else if(e.propertyCategory=="commercial"){
           commercialProperties!.add(e);
          }
        else if(e.propertyCategory=="agricultural"){
          agriculturalProperties!.add(e);
          }
         else if(e.propertyCategory=="industrial"){
           industrialProperties!.add(e);
          }
        });
        emit(GetAcceptPropertySuccessState());
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
    emit(GetAcceptPropertyErrorState());
    });
  }
}
