import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'connectivity_events.dart';
import 'connectivity_states.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    // Handle initial connectivity check
    on<CheckConnectivity>((event, emit) async {
      final connectivityResult = await _connectivity.checkConnectivity();
      emit(_mapConnectivityResultToState(
          connectivityResult as ConnectivityResult));
    });

    // Handle connectivity changes from the stream
    on<ConnectivityChanged>((event, emit) {
      if (event.connectionType == 'None') {
        emit(ConnectivityDisconnected());
      } else {
        emit(ConnectivityConnected(event.connectionType));
      }
    });

    // Listen for connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (connectivityResults) {
        for (var connectivityResult in connectivityResults) {
          final connectionType = _getConnectionType(connectivityResult);
          add(ConnectivityChanged(connectionType));
        }
      },
    );
  }

  /// Maps ConnectivityResult to ConnectivityState
  ConnectivityState _mapConnectivityResultToState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return ConnectivityConnected('WiFi');
      case ConnectivityResult.mobile:
        return ConnectivityConnected('Mobile');
      case ConnectivityResult.none:
        return ConnectivityDisconnected();
      default:
        return ConnectivityDisconnected();
    }
  }

  /// Converts ConnectivityResult to a readable connection type
  String _getConnectionType(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return 'WiFi';
      case ConnectivityResult.mobile:
        return 'Mobile';
      case ConnectivityResult.none:
        return 'None';
      default:
        return 'None';
    }
  }

  /// Cancel the subscription when the bloc is closed
  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
