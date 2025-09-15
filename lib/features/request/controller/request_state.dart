part of 'request_cubit.dart';

@immutable
sealed class RequestState {}

final class RequestInitial extends RequestState {}

class GetPendingRequestsLoadingState extends RequestState {}
class GetPendingRequestsSuccessState extends RequestState {}
class GetPendingRequestsErrorState extends RequestState {}

class ChangeRequestStatusLoadingState extends RequestState {}
class ChangeRequestStatusSuccessState extends RequestState {}
class ChangeRequestStatusErrorState extends RequestState {}

class AcceptRequestStatusLoadingState extends RequestState {}
class AcceptRequestStatusSuccessState extends RequestState {}
class AcceptRequestStatusErrorState extends RequestState {}

class RejectRequestStatusLoadingState extends RequestState {}
class RejectRequestStatusSuccessState extends RequestState {}
class RejectRequestStatusErrorState extends RequestState {}