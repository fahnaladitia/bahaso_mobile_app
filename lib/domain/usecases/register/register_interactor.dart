import 'package:bahaso_mobile_app/domain/repositories/repositories.dart';

import 'register_usecase.dart';

class RegisterInteractor implements RegisterUseCase {
  final IAuthRepository _repository;
  RegisterInteractor(this._repository);

  @override
  Future<void> call(RegisterParams params) {
    return _repository.register(params.email, params.password);
  }
}
