part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}
class AuthLoadingState extends AuthState {}
class AuthLoadedState extends AuthState {}
class AuthUpdateState extends AuthState {}
class AuthErrorState extends AuthState {}
