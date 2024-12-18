import 'package:equatable/equatable.dart';

abstract class ConnectivityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityConnected extends ConnectivityState {
  final String connectionType; // e.g., 'WiFi', 'Mobile'
  ConnectivityConnected(this.connectionType);

  @override
  List<Object?> get props => [connectionType];
}

class ConnectivityDisconnected extends ConnectivityState {}
