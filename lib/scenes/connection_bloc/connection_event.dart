part of 'connection_bloc.dart';

@immutable
abstract class ConnectivityEvent {}

class CheckConnectionEvent extends ConnectivityEvent{}

class HasConnectionEvent extends ConnectivityEvent{}

class NoConnectionEvent extends ConnectivityEvent{}
