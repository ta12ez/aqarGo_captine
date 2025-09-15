import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/showToast.dart';
import 'package:manzal_office/core/network/remote/apis_const.dart';
import 'package:manzal_office/core/network/remote/dioHelper.dart';
import 'package:manzal_office/core/network/remote/header_constance.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'accept_property_details_state.dart';

class AcceptPropertyDetailsCubit extends Cubit<AcceptPropertyDetailsState> {
  AcceptPropertyDetailsCubit() : super(AcceptPropertyDetailsInitial());
  List<String> images= [];
  void putImages (List<String> images1){
    images =images1;
  }

  int selectedIndex = 0;
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController();


  static AcceptPropertyDetailsCubit get(context) => BlocProvider.of(context);


  void selectImage(int index) {
    if (index >= 0 && index < images.length) {
      selectedIndex = index;
      _scrollToSelectedIndex(index);
      pageController.jumpToPage(index);

      emit(RequestImageChanged(images: images, selectedIndex: selectedIndex));
    }
  }
  void _scrollToSelectedIndex(int index) {
    const itemHeight = 98.0;
    final offset = itemHeight * index - 60;

    if (scrollController.hasClients) {
      scrollController.animateTo(
        offset < 0 ? 0 : offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      print("erorr");
    }
  }
Future<void>addAdvert( {required int id})async{
    emit(AddADSPropertyLoadingState());
    DioHelper.postData(url: ApiConstance.addAdverts,token: HeaderConstance.token,data: {
      "price":"10",
      "office_property_id":"${id}",
    }).then((value){
      if(value.statusCode==200){
        showToast(msg: "Added to ads", state: ToastState.SUCCESS);
        emit(AddADSPropertySuccessState());
      }
      else{
        showToast(msg: "حدث خطأ", state: ToastState.ERORR);
        emit(AddADSPropertyErrorState());
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
      emit(AddADSPropertyErrorState());
    });
}
Future<void>deleteProperty( {required int id})async{
    emit(DeletePropertyLoadingState());
    DioHelper.deleteData(url: ApiConstance.deleteProperty(id),token: HeaderConstance.token).then((value){
      if(value.statusCode==200){
        showToast(msg: "Deleted", state: ToastState.SUCCESS);
        emit(DeletePropertySuccessState());
      }
      else{
        showToast(msg: "حدث خطأ", state: ToastState.ERORR);
        emit(DeletePropertyErrorState());
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
      emit(DeletePropertyErrorState());
    });
  }


}
