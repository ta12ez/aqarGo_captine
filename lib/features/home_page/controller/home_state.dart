part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
class ChangeLanguageState extends HomeState {
  final Locale locale;
  ChangeLanguageState({required this.locale});

}
class GetSubsiciptionLoadingState extends HomeState{}
class GetSubsiciptionSuccessState extends HomeState{}
class GetSubsiciptionErrorState extends HomeState{}