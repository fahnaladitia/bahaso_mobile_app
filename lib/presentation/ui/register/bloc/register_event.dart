part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterSubmittedEvent extends RegisterEvent {
  final String email;
  final String password;

  const RegisterSubmittedEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'RegisterSubmittedEvent(email: $email, password: $password)';
}
