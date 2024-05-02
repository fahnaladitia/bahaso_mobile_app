import 'package:bahaso_mobile_app/core/common/exceptions/exceptions.dart';
import 'package:bahaso_mobile_app/domain/usecases/usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  LoginBloc(this._loginUseCase) : super(LoginInitial()) {
    on<LoginSubmittedEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        await _loginUseCase(LoginParams(email: event.email, password: event.password));
        emit(LoginSuccess());
      } on BaseException catch (e) {
        emit(LoginError(e.message));
      } catch (e) {
        emit(LoginError('An error occurred: $e'));
      }
    });
  }
}
