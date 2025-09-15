part of 'wallet_cubit.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}

class RechargeLoadingState extends WalletState{}
class RechargeSuccessState extends WalletState{}
class RechargeCanceledState extends WalletState {}

class RechargeErrorState extends WalletState{}
class GetBalanceLoadingState extends WalletState{}
class GetBalanceSuccessState extends WalletState{}
class GetBalanceErrorState extends WalletState{}

class GetTransactionLoadingState extends WalletState{}
class GetTransactionSuccessState extends WalletState{}
class GetTransactionErrorState extends WalletState{}

class ChangeChargeIndex extends WalletState{

}