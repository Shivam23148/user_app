part of 'internet_connectivity_bloc.dart';

abstract class InternetConnectivityState {}

class InternetConnectivityInitial extends InternetConnectivityState {}

class InternetConnected extends InternetConnectivityState {}

class InternetDisconnected extends InternetConnectivityState {}
