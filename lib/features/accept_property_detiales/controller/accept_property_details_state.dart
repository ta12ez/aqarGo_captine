part of 'accept_property_details_cubit.dart';

@immutable
sealed class AcceptPropertyDetailsState extends Equatable {}

final class AcceptPropertyDetailsInitial extends AcceptPropertyDetailsState {
  @override
  List<Object> get props => [];
}


class RequestDetailsInitial extends AcceptPropertyDetailsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RequestImageChanged extends AcceptPropertyDetailsState {
  final List<String> images;
  final int selectedIndex;

  RequestImageChanged({required this.images, required this.selectedIndex});

  @override
  // TODO: implement props
  List<Object?> get props => [images, selectedIndex];
}

class DeletePropertySuccessState extends AcceptPropertyDetailsState {
  @override
  List<Object> get props => [];
}
class DeletePropertyLoadingState extends AcceptPropertyDetailsState {
  @override
  List<Object> get props => [];
}
class DeletePropertyErrorState extends AcceptPropertyDetailsState {
  @override
  List<Object> get props => [];
}

class AddADSPropertySuccessState extends AcceptPropertyDetailsState {
  @override
  List<Object> get props => [];
}
class AddADSPropertyLoadingState extends AcceptPropertyDetailsState {
  @override
  List<Object> get props => [];
}
class AddADSPropertyErrorState extends AcceptPropertyDetailsState {
  @override
  List<Object> get props => [];
}