part of 'request_details_cubit.dart';

@immutable
abstract class RequestDetailsState extends Equatable{}

class ChangeRequestStatusLoadingState extends RequestDetailsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ChangeRequestStatusSuccessState extends RequestDetailsState{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class ChangeRequestStatusErrorState extends RequestDetailsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AcceptRequestStatusLoadingState extends RequestDetailsState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class AcceptRequestStatusSuccessState extends RequestDetailsState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class AcceptRequestStatusErrorState extends RequestDetailsState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RejectRequestStatusLoadingState extends RequestDetailsState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class RejectRequestStatusSuccessState extends RequestDetailsState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class RejectRequestStatusErrorState extends RequestDetailsState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RequestDetailsInitial extends RequestDetailsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RequestImageChanged extends RequestDetailsState {
  final List<String> images;
  final int selectedIndex;

  RequestImageChanged({required this.images, required this.selectedIndex});

  @override
  // TODO: implement props
  List<Object?> get props => [images,selectedIndex];
}
