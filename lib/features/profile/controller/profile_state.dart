part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
class GetProfileDataSuccess extends ProfileState{}
class GetProfileDataLoading extends ProfileState{}
class GetProfileDataError extends ProfileState{}


class LogOutloadingState extends ProfileState {}
class LogOutSuccessState extends ProfileState {}
class LogOutErrorState extends ProfileState {}