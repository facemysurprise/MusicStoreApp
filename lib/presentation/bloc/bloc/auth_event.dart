import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String country;

  SignUpRequested({required this.name, required this.email, required this.password, required this.phone, required this.country});

  @override
  List<Object> get props => [name, email, password, phone, country];
}

class SignOutRequested extends AuthEvent {}