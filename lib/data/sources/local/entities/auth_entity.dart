// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? token;
  final String? email;
  const AuthEntity({this.token, this.email});

  @override
  List<Object?> get props => [token, email];

  @override
  bool get stringify => true;
}
