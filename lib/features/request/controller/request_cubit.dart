import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/features/request/models/request_model.dart';
import 'package:meta/meta.dart';

import '../../../core/network/remote/apis_const.dart';
import '../../../core/network/remote/dioHelper.dart';
import '../../../core/network/remote/header_constance.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestCubit() : super(RequestInitial());
  static RequestCubit get (context)=> BlocProvider.of(context);

  RequestModel? requestModel;
  void getPendingRequest() {
    emit(GetPendingRequestsLoadingState());
    DioHelper.getData(
      url: ApiConstance.getPindingRequest,
      token: HeaderConstance.token,
    ).then((value) {
      if (value.statusCode == 200) {
        requestModel = RequestModel.fromJson(value.data);
        emit(GetPendingRequestsSuccessState());
        print(requestModel?.officeId);
      }
    }).catchError((e) {
      if (e is DioException) {
        if (e.response != null) {
          print("Error: ${e.toString()}");
        } else {
          print("Error1: ${e.message}");
        }
      } else {
        print("Unexpected error: ${e.toString()}");
      }
      emit(GetPendingRequestsErrorState());
    });
  }

  void acceptRequest({required dynamic officePropertyId}) {
    emit(AcceptRequestStatusLoadingState());
    DioHelper.getData(
      url: "${ApiConstance.acceptRequest}$officePropertyId",
      token: HeaderConstance.token,
    ).then((value) {
      if (value.statusCode == 200) {
        emit(AcceptRequestStatusSuccessState());
        getPendingRequest();
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
        getPendingRequest();
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

  // void  changeRequestStatus({required int id ,required String status}) {
  //   emit(ChangeRequestStatusLoadingState());
  //   DioHelper.postData(
  //     url: ApiConstance.changeRequestStatus,
  //     token: HeaderConstance.token,
  //     data: {
  //       "office_property_id":"$id",
  //       "status":"$status"
  //     }
  //   ).then((value) {
  //     if (value.statusCode == 200) {
  //       emit(ChangeRequestStatusSuccessState());
  //       getPendingRequest();
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


}
