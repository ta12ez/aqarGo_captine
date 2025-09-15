import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzal_office/features/followers/models/followers_model.dart';
import 'package:meta/meta.dart';

import '../../../core/network/remote/apis_const.dart';
import '../../../core/network/remote/dioHelper.dart';
import '../../../core/network/remote/header_constance.dart';

part 'followers_state.dart';

class FollowersCubit extends Cubit<FollowersState> {
  FollowersCubit() : super(FollowersInitial());
 static FollowersCubit get(context)=> BlocProvider.of(context);

 FollowersModel? followersModel;
  void getFollowers() {
    emit(GetFollowersLoadingState());
    DioHelper.getData(
      url: ApiConstance.getFollowersForOffice,
      token: HeaderConstance.token,
    ).then((value) {
      if (value.statusCode == 200) {
        followersModel = FollowersModel.fromJson(value.data);
        emit(GetFollowersSuccessState());
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
      emit(GetFollowersErrorState());
    });
  }


}
