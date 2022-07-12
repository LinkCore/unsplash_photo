import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import '../../common/app_text.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(ConnectionInitial()) {
    on<CheckConnectionEvent>(_onCheckConnection);
    on<HasConnectionEvent>(_onHasConnection);
    on<NoConnectionEvent>(_onNoConnection);

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        if (kDebugMode) {
          print(AppText.noConnection);
        }
        add(NoConnectionEvent());
      } else {
        if (kDebugMode) {
          print(AppText.thereIsAConnection);
        }
        add(HasConnectionEvent());
      }
    });
  }

  Future<FutureOr<void>> _onCheckConnection(
      CheckConnectionEvent event, Emitter<ConnectivityState> emit) async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      if (kDebugMode) {
        print(AppText.noConnection);
      }
      emit(NoConnectionState());
    } else {
      if (kDebugMode) {
        print(AppText.thereIsAConnection);
      }
      emit(HasConnectionState());
    }
  }

  FutureOr<void> _onHasConnection(
      HasConnectionEvent event, Emitter<ConnectivityState> emit) {
    emit(HasConnectionState());
  }

  FutureOr<void> _onNoConnection(
      NoConnectionEvent event, Emitter<ConnectivityState> emit) {
    emit(NoConnectionState());
  }
}
