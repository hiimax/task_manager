part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState extends Equatable {}

final class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

final class Loading extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

final class SignupError extends AuthenticationState {
  final String error;
  SignupError(this.error);

  @override
  List<Object?> get props => [error];
}

final class SignupSuccess extends AuthenticationState {
  final User user;

  SignupSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class LoginError extends AuthenticationState {
  final String error;

  LoginError(this.error);

  @override
  List<Object?> get props => [error];
}

final class LoginSuccess extends AuthenticationState {
  final User user;
  final UserModel? userModel;

  LoginSuccess(this.user, this.userModel);

  @override
  List<Object?> get props => [];
}

final class ResetPassowrdError extends AuthenticationState {
  final String error;

  ResetPassowrdError(this.error);

  @override
  List<Object?> get props => [error];
}

final class ResetPassowrdSuccess extends AuthenticationState {
  final String message;

  ResetPassowrdSuccess(this.message);

  @override
  List<Object?> get props => [];
}
