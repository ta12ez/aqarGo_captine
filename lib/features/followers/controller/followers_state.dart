part of 'followers_cubit.dart';

@immutable
sealed class FollowersState {}

final class FollowersInitial extends FollowersState {}

class GetFollowersSuccessState extends FollowersState {}
class GetFollowersLoadingState extends FollowersState {}
class GetFollowersErrorState extends FollowersState {}
