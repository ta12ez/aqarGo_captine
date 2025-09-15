import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/core/component/navigator.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/network/remote/apis_const.dart';
import '../../../core/network/remote/dioHelper.dart';
import '../../../core/network/remote/header_constance.dart';
part 'request_details_state.dart';


class RequestDetailsCubit extends Cubit<RequestDetailsState> {
   List<String> images= [];
  void putImages (List<String> images1){
    images =images1;
  }

  int selectedIndex = 0;
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController();

  RequestDetailsCubit():super(RequestDetailsInitial());

  static RequestDetailsCubit get(context) => BlocProvider.of(context);


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


   // void  changeRequestStatus({required int id ,required String status,required context}) {
   //   emit(ChangeRequestStatusLoadingState());
   //   DioHelper.postData(
   //       url: ApiConstance.changeRequestStatus,
   //       token: HeaderConstance.token,
   //       data: {
   //         "office_property_id":"$id",
   //         "status":"$status"
   //       }
   //   ).then((value) {
   //     if (value.statusCode == 200) {
   //       emit(ChangeRequestStatusSuccessState());
   //      navigatPop(context: context);
   //       print(value.data);
   //     }
   //   }).catchError((e) {
   //     if (e is DioException) {
   //       if (e.response != null) {
   //         print("Error: ${e.response?.data}");
   //       } else {
   //         print("Error1: ${e.message}");
   //       }
   //     } else {
   //       print("Unexpected error: $e");
   //     }
   //     emit(ChangeRequestStatusErrorState());
   //   });
   // }

   void acceptRequest({required dynamic officePropertyId}) {
     emit(AcceptRequestStatusLoadingState());
     DioHelper.getData(
       url: "${ApiConstance.acceptRequest}$officePropertyId",
       token: HeaderConstance.token,
     ).then((value) {
       if (value.statusCode == 200) {
         emit(AcceptRequestStatusSuccessState());
         print(value.data);
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
       emit(AcceptRequestStatusErrorState());
     });
   }

   void rejectRequest({required dynamic officePropertyId}) {
     emit(RejectRequestStatusLoadingState());
     DioHelper.getData(
       url: "${ApiConstance.rejectRequest}$officePropertyId",
       token: HeaderConstance.token,
     ).then((value) {
       if (value.statusCode == 200) {
         emit(RejectRequestStatusSuccessState());
         print(value.data);
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
       emit(RejectRequestStatusErrorState());
     });
   }




}
