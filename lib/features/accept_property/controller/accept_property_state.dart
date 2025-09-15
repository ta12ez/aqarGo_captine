part of 'accept_property_cubit.dart';

@immutable
sealed class AcceptPropertyState {}

final class AcceptPropertyInitial extends AcceptPropertyState {}
class GetAcceptPropertySuccessState extends AcceptPropertyState{}
class GetAcceptPropertyLoadingState extends AcceptPropertyState{}
class GetAcceptPropertyErrorState extends AcceptPropertyState{}