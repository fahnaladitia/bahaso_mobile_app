import 'package:bahaso_mobile_app/domain/usecases/usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/common/exceptions/exceptions.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  RegisterBloc(this._registerUseCase) : super(RegisterInitial()) {
    on<RegisterSubmittedEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
        await _registerUseCase(RegisterParams(email: event.email, password: event.password));
        emit(RegisterSuccess());
      } on BaseException catch (e) {
        emit(RegisterError(e.message));
      } catch (e) {
        emit(RegisterError('An error occurred: $e'));
      }
    });
  }
}
