part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable {}

class SignupEvent extends AuthenticationEvent {
  final String email;
  final String fullName;
  final String password;

  SignupEvent({
    required this.email,
    required this.password,
    required this.fullName,
  });

  @override
  List<Object> get props => [email, password, fullName];
}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class ResetPasswordEvent extends AuthenticationEvent {
  final String email;

  ResetPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}
