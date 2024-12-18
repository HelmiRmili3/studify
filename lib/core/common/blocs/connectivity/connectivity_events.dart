import 'package:equatable/equatable.dart';

abstract class ConnectivityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckConnectivity extends ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final String connectionType; // e.g., 'WiFi', 'Mobile', 'None'
  ConnectivityChanged(this.connectionType);

  @override
  List<Object?> get props => [connectionType];
}
