part of 'internet_connectivity_bloc.dart';

abstract class InternetConnectivityEvent {}

class InternetConnectivityChanged extends InternetConnectivityEvent {
  final ConnectivityResult connectivityResult;

  InternetConnectivityChanged(this.connectivityResult);
}
