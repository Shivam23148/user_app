import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_connectivity_event.dart';
part 'internet_connectivity_state.dart';

class InternetConnectivityBloc
    extends Bloc<InternetConnectivityEvent, InternetConnectivityState> {
  final Connectivity connectivity = Connectivity();
  InternetConnectivityBloc() : super(InternetConnectivityInitial()) {
    on<InternetConnectivityChanged>((event, emit) {
      if (event.connectivityResult == ConnectivityResult.mobile ||
          event.connectivityResult == ConnectivityResult.wifi) {
        emit(InternetConnected());
      } else if (event.connectivityResult == ConnectivityResult.none) {
        emit(InternetDisconnected());
      }
    });
    connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      add(InternetConnectivityChanged(result.last));
    });
  }
}
