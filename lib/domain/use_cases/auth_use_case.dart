import 'package:flutter_application_firebase/data/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<void> execute(String email, String password) async {
    await repository.signInWithEmailAndPassword(email, password);
  }
}


class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<void> execute(String email, String password, String name, String phone, String country) async {
    await repository.signUpWithEmailAndPassword(email, password, name, phone, country);
  }
}


class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<void> execute() async {
    await repository.signOut();
  }
}