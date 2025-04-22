import 'package:equatable/equatable.dart';

abstract class RoutingState extends Equatable{
  const RoutingState();

  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends RoutingState {}

class AuthenticationAuthenticated extends RoutingState {}

class AuthenticationUnauthenticated extends RoutingState {}

class AuthenticationLoading extends RoutingState {}
