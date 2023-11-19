import 'package:flutter_application_firebase/data/repositories/auth_repository.dart';
import 'package:flutter_application_firebase/presentation/bloc/bloc/auth_event.dart';
import 'package:flutter_application_firebase/presentation/bloc/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signInWithEmailAndPassword(event.email, event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signUpWithEmailAndPassword(event.email, event.password, event.name, event.phone, event.country);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignOutRequested>((event, emit) async {
      await authRepository.signOut();
      emit(Unauthenticated());
    });
  }
}