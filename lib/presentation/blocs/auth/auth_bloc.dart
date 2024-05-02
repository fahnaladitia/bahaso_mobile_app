import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckEvent>((__, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(AuthUnauthenticated());
    });
    on<AuthLogoutEvent>((_, emit) {
      emit(AuthUnauthenticated());
    });
  }
}
