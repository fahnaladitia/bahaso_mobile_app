import 'package:bahaso_mobile_app/domain/repositories/repositories.dart';

import 'login_usecase.dart';

class LoginInteractor implements LoginUseCase {
  final IAuthRepository _repository;
  LoginInteractor(this._repository);

  @override
  Future<void> call(LoginParams params) {
    return _repository.login(params.email, params.password);
  }
}
