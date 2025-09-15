part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}
class EditProfileSuccessState extends EditProfileState{}
class EditProfileLoadingState extends EditProfileState{}
class EditProfileErrorState extends EditProfileState{}
class AddImagesUpdated extends EditProfileState{}