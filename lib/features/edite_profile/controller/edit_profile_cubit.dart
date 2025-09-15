import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manzal_office/core/component/showToast.dart';
import 'package:manzal_office/core/network/remote/apis_const.dart';
import 'package:manzal_office/core/network/remote/dioHelper.dart';
import 'package:manzal_office/core/network/remote/header_constance.dart';
import 'package:meta/meta.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());
  static EditProfileCubit get(context)=>BlocProvider.of(context);
  XFile? images;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      images = image;
      emit(AddImagesUpdated());
    }
  }

  void editProfile({
    String? name,
    String? email,
    String? phone,
    String? percentage,
    String? description,
})async{
    emit(EditProfileLoadingState());
    try{
    var data = FormData.fromMap({
      if(images!=null)
      'image': [
        await MultipartFile.fromFile(images!.path, filename: images!.name)
      ],
      if(name!=null)
        'Office_name': '$name',
      if(email!=null)
      'email':'$email',
      if(description!=null)
      'description':'$description',
      if(percentage!=null)
      'percentage':'$percentage'
    });
    DioHelper.postData(url: ApiConstance.updateProfile,token: HeaderConstance.token,data: data)
    .then((value){
      if(value.statusCode==200){
        showToast(msg: "تم التعديل", state: ToastState.SUCCESS);
        emit(EditProfileSuccessState());
      }
    }) .catchError((e){
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
      emit(EditProfileErrorState());
    });

  }
  catch(e){
    showToast(msg: "حدث خطأ", state: ToastState.ERORR);

    print("Error: ${e.toString()}");
    emit(EditProfileErrorState());

  }
  }
}
