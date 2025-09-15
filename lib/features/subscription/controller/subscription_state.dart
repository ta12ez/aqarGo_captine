part of 'subscription_cubit.dart';

@immutable
sealed class SubscriptionState {}

final class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoadingState extends SubscriptionState{}
class SubscriptionSuccessState extends SubscriptionState{}
class SubscriptionCanceledState extends SubscriptionState {}

class SubscriptionErrorState extends SubscriptionState{}