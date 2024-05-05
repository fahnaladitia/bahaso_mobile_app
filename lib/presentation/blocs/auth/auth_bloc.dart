import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/models.dart';
import '../../../domain/usecases/usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckLoginUseCase _checkLoginUseCase;
  final LogoutUseCase _logoutUseCase;
  AuthBloc(this._checkLoginUseCase, this._logoutUseCase) : super(AuthInitial()) {
    on<AuthCheckEvent>((__, emit) async {
      emit(AuthLoading());
      final auth = await _checkLoginUseCase();
      if (auth != null) {
        emit(AuthAuthenticated(auth));
      } else {
        emit(AuthUnauthenticated());
      }
    });
    on<AuthLogoutEvent>((_, emit) async {
      await _logoutUseCase();
      emit(AuthUnauthenticated());
    });
  }
}
