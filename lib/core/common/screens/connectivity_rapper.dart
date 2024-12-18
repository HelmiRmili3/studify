import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studify/core/common/blocs/connectivity/connetivity_bloc.dart';
import 'package:studify/core/utils/app_snack_bar.dart';

import '../blocs/connectivity/connectivity_states.dart';

// ignore: must_be_immutable
class ConnectivityWrapper extends StatelessWidget {
  final Widget child;

  ConnectivityWrapper({super.key, required this.child});

  OverlayEntry? _currentOverlay;

  void _removeCurrentSnackBar() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityConnected) {
          // Remove any displayed Snackbar when connectivity is restored
          _removeCurrentSnackBar();
          AppSnackBar.showTopSnackBar(
              context, 'You are back online!', Colors.green);
          Future.delayed(const Duration(seconds: 2), () {
            _removeCurrentSnackBar();
          });
        } else if (state is ConnectivityDisconnected) {
          // Display the Snackbar until connectivity is back
          AppSnackBar.showTopSnackBar(
              context, 'No Internet Connection', Colors.red.withOpacity(0.9));
        }
      },
      child: BlocBuilder<ConnectivityBloc, ConnectivityState>(
        builder: (context, state) {
          return child;
        },
      ),
    );
  }
}
